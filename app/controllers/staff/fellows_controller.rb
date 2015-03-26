class Staff::FellowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @fellows = Fellow.all
  end

  def new
    @fellow = Fellow.new
    @fellows = Fellow.all
  end

  def create
    @fellow = Fellow.new(fellow_params.merge({password: "12345678", password_confirmation: "12345678"}))
    if @fellow.save
      redirect_to staff_fellows_path, notice: "Fellow successfully saved."
    else
      render :new, alert: "Fellow could not be saved."
    end
  end

  def edit
    @fellow = Fellow.find(params[:id])
  end

  def update
    @fellow = Fellow.find(params[:id])
    @fellow.update(fellow_params)
    if @fellow.save
      redirect_to staff_fellows_path
      flash[:notice] = "fellow successfully updated."
    else
      render :edit
      flash[:notice] = "Fellow could not be updated."
    end
  end

  def show
    @fellow = Fellow.find(params[:id])
    @goals = @fellow.goals
  end

  def destroy
    @fellow = Fellow.find(params[:id])
    @fellow.destroy
    redirect_to staff_fellows_path
    flash[:notice] = "Fellow successfully deleted"
  end

  private

  def fellow_params
    params.require(:fellow).permit(:first_name, :last_name, :email, :role)
  end
end
