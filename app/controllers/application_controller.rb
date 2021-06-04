class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :authenticate_user!, unless: :devise_controller?
  after_action { pagy_headers_merge(@pagy) if @pagy }
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pagy::Backend

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :company_id])
  end
end
