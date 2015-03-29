class GoalMailer < ActionMailer::Base
  default :from => "notify@uncollege.org"

  def delete_email(coach, goal, fellow)
    @coach = coach
    @goal  = goal
    @fellow = fellow
    mail(:to => coach.email,
    :subject => "Goal Deleted")
  end
end