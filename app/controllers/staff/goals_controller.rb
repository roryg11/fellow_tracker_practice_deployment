class Staff::GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @fellow = Fellow.find(params[:fellow_id])
  end

  def index
    @goals = @fellow.goals
  end

  def new
    @goal = @fellow.goals.new
  end

  def create
    @goal = @fellow.goals.create(goal_params)
    if @goal.save
      redirect_to staff_fellow_path(@fellow)
    else
      render :new
    end
  end

  def edit
    @goal = @fellow.goals.find(params[:id])
  end

  def update
    @goal = @fellow.goals.find(params[:id])
    @goal.update(goal_params)
    if @goal.save
      redirect_to staff_fellow_path(@fellow)
    else
      render :edit
    end
  end

  def destroy
    @goal = @fellow.goals.find(params[:id])
    @goal.destroy
    redirect_to staff_fellow_path(@fellow)
    flash[:alert] = "Goal has been deleted."
  end

  private

  def goal_params
    params.require(:goal).permit(
    :description, :due_date, :completed, :user_id, :notes
    )
  end

end
