class LandingController < ApplicationController
  layout 'home'

  def welcome
    @pagination = 1
  end

  def how
    @pagination = 2
  end

  def who
    @pagination = 3
  end

  def where
    @pagination = 4
  end

  def agree
    @pagination = 5
  end

  def final
    @pagination = 6
    @mail = MailingListMail.new
  end
end
