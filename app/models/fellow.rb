class Fellow < User
  has_one :mentorship

  def full_name
    "#{first_name} #{last_name}"
  end
  def self.avail_fellows
    @avail_fellows = Fellow.select { |fellow| fellow.cohorts.length == 0 }
  end

  def week_progress
    monday = Date.today.beginning_of_week
    sunday = monday + 6
    (((self.goals.where(completed: true, due_date: monday..sunday ).length).to_f/(self.goals.length).to_f) * 100).floor
  end

  def overall_progress
    (((self.goals.where(completed: true).length).to_f/(self.goals.length).to_f) * 100).floor
  end
end

# fellow has one primary_coach (through mentorship)
# coach has many mentees (through mentorship)
