module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = policy_scope(User).order(:created_at)
      authorize User
    end

    def show
      authorize @user
    end

    def edit
      authorize @user
    end

    def password_edit
      authorize :dashboard, :show?
      @user = current_user
    end

    def password_update
      authorize :dashboard, :show?
      @user = current_user

      if @user.update_with_password(password_params)
        redirect_to admin_user_path(@user), notice: "Password was successfully updated."
      else
        render :password_edit, status: :unprocessable_entity
      end
    end

    def update
      authorize @user

      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @user
      @user.destroy
      redirect_to admin_users_path, notice: "User was successfully deleted."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role, :avatar)
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
  end
end
