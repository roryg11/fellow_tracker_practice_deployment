class Admin::UsersController < ApplicationController
  def index
    @users = User.where("admin = false")
  end

  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.create(user_params.merge({password: "12345678", password_confirmation: "12345678"}))
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

  def staff
    @users = User.where("admin = true")
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :user_id, :cohort_id)
  end
end
