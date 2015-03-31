class Fellow < User
  has_one :mentorship
  has_one :coach, through: :mentorship
  has_many :cohorts, through: :memberships

  def cohort
    cohorts.first
  end

  def self.avail_fellows
    @avail_fellows = Fellow.select { |fellow| fellow.cohorts.length == 0 }
  end

  def week_progress(week_number = nil)
    return unless cohort
    week_number ||= cohort.weeks_from_start

    completed_goals = goals.where(completed: true, due_date: cohort.week_range(week_number))
    total_goals = goals.where(due_date: cohort.week_range(week_number))

    return 0 if total_goals.empty?
    ((completed_goals.length.to_f/total_goals.length.to_f) * 100).floor
  end

  def overall_progress
    if self.goals.length > 0
      (((self.goals.where(completed: true).length).to_f/(self.goals.length).to_f) * 100).floor
    else
      0
    end
  end

  def this_weeks_goals
    monday = Date.today.beginning_of_week
    sunday = monday + 6
    if self.goals.length > 0
      self.goals.where(due_date: monday..sunday)
    end
  end
end

# fellow has one primary_coach (through mentorship)
# coach has many mentees (through mentorship)
