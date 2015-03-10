class Admin::GoalsController < ApplicationController
  before_action do
    @user = current_user
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






  private

  def goal_params
    params.require(:goal).permit(
    :description, :due_date, :completed, :user_id,
    )
  end
  
end
