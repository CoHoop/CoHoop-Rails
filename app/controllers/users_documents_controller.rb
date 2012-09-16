class UsersDocumentsController < ApplicationController
  before_filter :authenticate_user!, only: [:update, :create, :new]

  def show
    @user  = get_user_through_params || return
    @document = Document.new();
    @title = 'Documents'
  end

  def new
    @user     = get_user_through_params || return
  end

  def create
    @user     = get_user_through_params || return
    doc_name  = params[:document][:name]
    document  = Document.new(name: doc_name)
    document.create_slug

    if document.valid?
      document.save
      @user.documents_relationships.build(document_id: document.id)
      @user.save
    else
      respond_to do |format|
        format.js
      end
    end
  end
end
