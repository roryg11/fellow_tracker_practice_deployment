class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params.merge({password: "12345678", password_confirmation: "12345678"}))
    if @user.save
      redirect_to admin_users_path, notice: "Fellow successfully saved."
    else
      render :new, alert: "Fellow could not be saved."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
