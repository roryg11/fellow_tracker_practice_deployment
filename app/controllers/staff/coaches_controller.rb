class Staff::CoachesController < ApplicationController
  before_action :authenticate_user!

  def index
    @coaches = Coach.all
  end

  def new
    @coach = Coach.new
    @coaches = Coach.all
  end

  def create
    @coach = Coach.new(coach_params.merge({password: "12345678", password_confirmation: "12345678"}))
    if @coach.save
      redirect_to staff_coaches_path, notice: "Coach successfully saved."
    else
      render :new, alert: "Coach could not be saved."
    end
  end

  def edit
    @coach = Coach.find(params[:id])
  end

  def update
    @coach = Coach.find(params[:id])
    @coach.update(coach_params)
    if @coach.save
      redirect_to staff_coaches_path
      flash[:notice] = "Coach successfully updated."
    else
      render :edit
      flash[:notice] = "Coach could not be updated."
    end
  end

  def show
    @coach = Coach.find(params[:id])
  end

  private

  def coach_params
    params.require(:coach).permit(:first_name, :last_name, :email, :role)
  end
end
