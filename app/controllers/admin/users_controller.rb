class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_role

  def index
    @users = User.all
  end

  def new
    @user = role_class.new
    @users = User.all
  end

  def create
    @user = role_class.create(user_params.merge({password: "12345678", password_confirmation: "12345678"}))
    if @user.save
      redirect_to admin_users_path, notice: "Fellow successfully saved."
    else
      render :new, alert: "Fellow could not be saved."
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to admin_user_path
      flash[:notice] = "User successfully updated."
    else
      render :edit
      flash[:notice] = "User could not be updated."
    end
  end

  def show
    @user = User.find(params[:id])
    @goals = @user.goals
  end

  private

  def user_params
    params.require(role.underscore.to_sym).permit(:first_name, :last_name, :email, :role)
  end

  def set_role
    @role = role
  end

  def role
    User.roles.include?(params[:role]) ? params[:role] : "User"
  end

  def role_class
    role.constantize
  end

  def set_user
    @user = role_class.find(params[:id])
  end
end
