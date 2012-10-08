class UsersDocumentsController < ApplicationController
  before_filter :authenticate_user!, only: [:update, :create, :new]

  def show
    @user     = get_user_through_params || return

    ether     = EtherpadLite.connect('http://docs.cohoop.com', 'Hxo0L3mVABqNCAsGl8cEZEXCajIxMYa0')
    ether.client.ListPadsOfAuthor(authorID: 'a.' + @user.id.to_s)

    user_groups = @user.groups
    ap(ep_groups)
    ap(user_groups)

    @group = user_groups
    @document = Document.new();

    @title    = 'Documents'
  end

  def new
    @user     = get_user_through_params || return
  end

  def create
    @user     = get_user_through_params || return

    group     = Group.new()
    group.create_slug(@user)

    doc_name  = params[:document][:name]
    document  = Document.new(name: doc_name)
    document.create_slug

    if document.valid? && group.valid?
      # TODO: Refactor
      ether = EtherpadLite.connect('http://docs.cohoop.com', 'Hxo0L3mVABqNCAsGl8cEZEXCajIxMYa0')
      ether.create_group mapper: group.slug

      document.groups_relationships.build(document_id: document.id)
      document.save

      @user.groups_relationships.build(group_id: group.id)
      @user.save
    else
      respond_to do |format|
        format.js
      end
    end
  end
end
