class RegistrationsController < Devise::RegistrationsController
  before_filter :has_token?, only: [:new, :create]
  after_filter  :delete_token, only: [:create]

  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  private
    def has_token?
      token = session[:token] ? session[:token][:uid] : params[:token]
      redirect_to :root unless token == current_token

      if !session[:token]
        session[:token] = {
          uid: current_token
        }
      end
    end

    def delete_token
      session[:token] = nil
      # Manage token destruction in DB
    end

    def current_token
      # TODO: Handle random token generation and retrieving from DB
      'cohoop'
    end
end
