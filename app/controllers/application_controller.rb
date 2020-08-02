class ApplicationController < ActionController::Base
  def ensure_signed_in
    return nil if signed_in?

    redirect_to new_user_session_path
  end
end
