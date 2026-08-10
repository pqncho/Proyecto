# frozen_string_literal: true
class UsersController < InertiaController
  before_action :require_login, only: [:show, :update]

  def new
    render inertia: 'register/NewR'
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to register_path, inertia: { errors: user.errors }
    end
  end

  def show
    render inertia: 'profile/NewP', props: {
      user: current_user.as_json(only: [:id, :name, :email]),
      articles: current_user.articles.as_json(only: [:id, :title, :body])
    }
  end

  def update
    if params[:user][:password].present? && params[:user][:password] != params[:user][:password_confirmation]
      redirect_to profile_path, inertia: { errors: { password_confirmation: "no coincide con la contraseña" } }
      return
    end

    if current_user.update(user_update_params)
      redirect_to profile_path, notice: 'Perfil actualizado con éxito'
    else
      redirect_to profile_path, inertia: { errors: current_user.errors.to_hash.transform_values(&:first) }
    end
 end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    permitted = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    permitted[:password].blank? ? permitted.except(:password, :password_confirmation) : permitted
  end
end