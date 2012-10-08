class DocumentsController < ApplicationController
  #before_filter :authenticate_user!, only: [:update]

  def show
    # TODO: Use configuration file
    ether = EtherpadLite.connect('http://docs.cohoop.com', 'Hxo0L3mVABqNCAsGl8cEZEXCajIxMYa0')

    @group = ether.get_group(params[:ep_group_id])
    @pad =   @group.pad(params[:pad_id])

    author = ether.author("cohoop_user_#{ current_user.id}", :name => current_user.name)
    # Get or create an hour-long session for this Author in this Group
    sess = session[:ep_sessions][@group.id] ? ether.get_session(session[:ep_sessions][@group.id]) : @group.create_session(author, 60)
    if sess.expired?
      sess.delete
      sess = @group.create_session(author, 60)
    end
    session[:ep_sessions][@group.id] = sess.id
    # Set the EtherpadLite session cookie. This will automatically be picked up by the jQuery plugin's iframe.
    cookies[:sessionID] = { :value => sess.id, :domain => ".yourdomain.com" }

    @title = "#{@pad.name}"
  end
end
