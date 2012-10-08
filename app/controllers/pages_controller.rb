class PagesController < ApplicationController
  layout 'home', only: [:home]
  def home
    @mail = MailingListMail.new
  end
end
