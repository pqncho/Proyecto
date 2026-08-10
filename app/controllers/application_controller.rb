class ApplicationController < ActionController::Base

  allow_browser versions: :modern

  helper_method :current_user


  def current_user
    User.find_by(id: session[:user_id])
  end


  private


  def require_login
  unless current_user
    redirect_to login_path, alert: "Tenés que iniciar sesión"
  end
end


end