class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::HttpAuthentication::Token::ControllerMethods
  rescue_from ActiveRecord::RecordNotFound, with: :four_oh_four

  def four_oh_four
    head 404
  end

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  private

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end

  def render_unauthorized(error)
    render json: { error: error }, status: 401
  end
end
