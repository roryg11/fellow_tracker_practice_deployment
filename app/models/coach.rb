class Coach < User
  has_many :mentorships
  has_many :fellows, through: :mentorships

  def self.not_members_of(cohort)
    Coach.select {|c| !c.cohorts.include?(cohort) }
  end

  def overall_fellow_progress
    aggregate_fellow_progress = 0
    num_fellows = fellows.length
    all_fellow_progress = 0
    fellows.each do |fellow|
      aggregate_fellow_progress += fellow.overall_progress
    end
    if num_fellows > 0
      all_fellow_progress = aggregate_fellow_progress/num_fellows
    end
    all_fellow_progress
  end

  def weekly_fellow_progress
    aggregate_fellow_progress = 0
    num_fellows = fellows.length
    all_fellow_progress = 0
    fellows.each do |fellow|
      aggregate_fellow_progress += fellow.week_progress
    end
    if num_fellows > 0
      all_fellow_progress = aggregate_fellow_progress/num_fellows
    end
    all_fellow_progress
  end
end
