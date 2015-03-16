class Admin::GoalsController < ApplicationController
  before_action do
    @user = current_user
  end

  def index
    @goals = @user.goals
    @cohort_start_date = @user.cohort.start_date
    @week_number = 1
    @first_monday = @user.cohort.first_monday
    @cohort_phase_array = []
    52.times do
      week_hash = {}
      week_hash[:week_number] = @week_number
      week_hash[:start] = (@first_monday + (7*(@week_number -1))).strftime("%B %d %Y")
      week_hash[:end] = (@first_monday + (7*(@week_number -1)) + 6).strftime("%B %d %Y")
      week_hash[:goals] = []
      week_hash[:goals] = @goals.where(due_date: week_hash[:start]..week_hash[:end])
      @cohort_phase_array.push(week_hash)
      @week_number+=1
     end
    p @cohort_phase_array
  end

  def new
    @goal = @user.goals.new
  end

  def create
    @goal = @user.goals.create(goal_params)
    if @goal.save
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def edit
    @goal = @user.goals.find(params[:id])
  end

  def update
    @goal = @user.goals.find(params[:id])
    @goal.update(goal_params)
    if @goal.save
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @goal = @user.goals.find(params[:id])
    @goal.destroy
    redirect_to admin_user_path(@user)
    flash[:alert] = "Goal has been deleted."
  end

  private

  def goal_params
    params.require(:goal).permit(
    :description, :due_date, :completed, :user_id,
    )
  end

end
