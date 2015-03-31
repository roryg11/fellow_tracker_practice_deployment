class Fellow < User
  has_one :mentorship
  has_one :coach, through: :mentorship

  def self.avail_fellows
    @avail_fellows = Fellow.select { |fellow| fellow.cohorts.length == 0 }
  end

  def week_progress
    monday = Date.today.beginning_of_week
    sunday = monday + 6
    if (self.goals.length) > 0
      (((self.goals.where(completed: true, due_date: monday..sunday ).length).to_f/(self.goals.length).to_f) * 100).floor
    else
      0
    end
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
