# module for helping request specs
module ValidUserRequestHelper

  # Public: Sign in a user with specified informations
  #
  # user: User object
  #
  # It returns Nothing.
  def sign_in_as user
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  # Public: Sign in a user
  #
  # It returns Nothing.
  def sign_in_as_a_valid_user
    user = FactoryGirl.create :user
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'

    user
  end
end