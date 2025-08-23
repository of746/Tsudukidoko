class ApplicationController < ActionController::Base
  def auto_login_as_guest
    unless user_signed_in? || session[:guest_logged_in]
      guest = User.find_or_create_by!(email: "guest@example.com") do |user|
        user.password = "password"
        user.password_confirmation = "password"
      end
      sign_in(guest)
      session[:guest_logged_in] = true
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
