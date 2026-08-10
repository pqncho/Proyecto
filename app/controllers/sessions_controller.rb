# frozen_string_literal: true
class SessionsController < InertiaController
  def new
    render inertia: 'sessions/newS'
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path, inertia: { errors: { base: "Correo o contraseña incorrectos" } }
    end
  end

  def destroy
  session[:user_id] = nil
  redirect_to root_path
end
end