class Staff::MembershipsController < ApplicationController
  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end
  def create
    @membership = @cohort.memberships.new(membership_params)
    if @membership.save
      redirect_to edit_staff_cohort_path(@cohort)
      flash[:notice] = "Member successfully added"
    else
      flash[:alert] = "Member could not be added."
    end
  end

  private
  def membership_params
    params.require(:membership).permit(:cohort_id, :user_id)
  end
end
