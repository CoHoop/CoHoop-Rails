class DocumentsController < ApplicationController
  #before_filter :authenticate_user!, only: [:update]

  def show
    @pad   = OpenStruct.new()
    @pad.id  = params[:id]
    @title = "#{@pad.id}"
  end
end
