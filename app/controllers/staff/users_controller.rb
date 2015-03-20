class Staff::UsersController < ApplicationController
    before_action :authenticate_user!

    def index
      @user = User.all
    end

    def new
      @staff = user.new
    end

    def create
      @user = user.new(user_params.merge({password: "12345678", password_confirmation: "12345678"}))
      if @user.save
        redirect_to staff_users_path, notice: "user successfully saved."
      else
        render :new, alert: "user could not be saved."
      end
    end

    def edit
      @user = user.find(params[:id])
    end

    def update
      @user = user.find(params[:id])
      @user.update(user_params)
      if @user.save
        redirect_to staff_users_path
        flash[:notice] = "user successfully updated."
      else
        render :edit
        flash[:notice] = "user could not be updated."
      end
    end

    def show
      @user = user.find(params[:id])
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role)
    end

    def set_user
      @user = user.find(params[:id])
    end
  end

end
