class MailsListController < ApplicationController
  respond_to :js

  def create
    ap params
    mail = MailingListMail.new(params[:mailing_list_mail])
    if mail.valid?
      mail.save!
      @message = 'Your mail has been registered.'
    else
      @message = 'There has been an issue, please try again.'
    end
  end
end
