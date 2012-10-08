class SessionsController < Devise::SessionsController
  after_filter :create_etherpad_session, only: [:create]
  after_filter :destroy_etherpad_session, only: [:destroy]

  def create
    super
  end

  def destroy
    super
  end

  private
  def create_etherpad_session
    session[:ep_sessions] = {}
  end

  def destroy_etherpad_session
    session[:ep_sessions] = nil
  end
end
