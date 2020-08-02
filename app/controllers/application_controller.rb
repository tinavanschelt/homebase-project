class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_signed_in
    return nil if signed_in?

    redirect_to new_user_session_path
  end

  protected

  def configure_permitted_parameters
    keys = %i[
      first_name
      last_name
      dob
      role
    ]

    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end
end
