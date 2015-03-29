class GoalsController < ApplicationController
  before_action do
    @user = current_user
  end

  def goals
    @goals = @user.goals
    @monday = Date.today.at_beginning_of_week
    @sunday = (Date.today.at_beginning_of_week + 7)
    @goals = @goals.where(due_date: @monday..@sunday)
  end

  def history
    if @user.memberships.any?
      @goals = @user.goals
      @cohort_start_date = @user.cohorts[0].start_date
      @week_number = 1
      @first_monday = @user.cohorts[0].first_monday
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
    else
      redirect_to goals_path
    end
  end

  def new
    @goal = @user.goals.new
  end
  def show
    if @user.memberships.any?
      @goals = @user.goals
    else
      redirect_to goals_path
    end
  end

  def create
    @goal = @user.goals.create(goal_params)
    if @goal.save
      flash[:notice] = "Goal successfully created"
      redirect_to goals_path
    else
      render :new
      flash[:alert] = "Goal could not be created"
    end
  end

  def edit
    @goal = @user.goals.find(params[:id])
  end

  def update
    @goal = @user.goals.find(params[:id])
    @goal.update(goal_params)
    if @goal.save
      redirect_to goals_path
    else
      render :edit
      flash[:alert] = "Goal could not be saved"
    end
  end

  def destroy
    @goal = @user.goals.find(params[:id])
    @coach = @user.mentorship.coach
    if @goal.destroy
      GoalMailer.delete_email(@coach, @goal, @user).deliver
      redirect_to goals_path
      flash[:alert] = "Goal has been deleted."
    else
      render :edit
      flash[:alert] = "Goal could not be deleted."
    end
  end

  private

  def goal_params
    params.require(:goal).permit(
    :description, :due_date, :completed, :user_id, :notes
    )
  end

end
