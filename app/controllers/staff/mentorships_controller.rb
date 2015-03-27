class Staff::MentorshipsController < ApplicationController
  before_action do
    @coach = Coach.find(params[:coach_id])
  end
  def create
    @mentorship= @coach.mentorships.new(mentorship_params)
    if @mentorship.save
      redirect_to staff_coach_path(@coach)
      flash[:notice] = "Mentorship successfully added"
    else
      flash[:alert] = "Mentorship could not be added."
    end
  end

  private
  def mentorship_params
    params.require(:mentorship).permit(:coach_id, :fellow_id)
  end
end