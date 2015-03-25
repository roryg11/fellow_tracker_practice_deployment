class Staff::GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @fellow = Fellow.find(params[:fellow_id])
  end

  def index
    @goals = @fellow.goals
    if @fellow.memberships.any?
      @goals = @fellow.goals
      @cohort_start_date = @fellow.cohorts[0].start_date
      @week_number = 1
      @first_monday = @fellow.cohorts[0].first_monday
      @cohort_phase_array = []
      weeks_since_launch = ((Date.today - @first_monday)/7).ceil.to_i
      weeks_since_launch.times do
        week_hash = {}
        week_hash[:week_number] = @week_number
        week_hash[:start] = (@first_monday + (7*(@week_number -1))).strftime("%B %d %Y")
        week_hash[:end] = (@first_monday + (7*(@week_number -1)) + 6).strftime("%B %d %Y")
        week_hash[:goals] = []
        week_hash[:goals] = @goals.where(due_date: week_hash[:start]..week_hash[:end])
        @cohort_phase_array.push(week_hash)
        @week_number+=1
       end
     @cohort_phase_array
   end
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
    :description, :due_date, :completed, :user_id,
    )
  end

end
