# frozen_string_literal: true
module Admin
  class UsersController < InertiaController
    before_action :require_login
    before_action :require_admin

    def index
      render inertia: 'admin/NewAd', props: {
        users: User.all.select(:id, :name, :email, :admin, :created_at)
      }
    end

    def destroy
      user = User.find(params[:id])

      if user == current_user
        return redirect_to admin_users_path, alert: "No podés eliminarte a vos mismo"
      end

      user.destroy
      redirect_to admin_users_path, notice: "Usuario eliminado"
    end

    private

    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "No autorizado"
      end
    end
  end
end