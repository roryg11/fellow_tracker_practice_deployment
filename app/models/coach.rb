class Coach < User
  has_many :mentorships
  has_many :fellows, through: :mentorships

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.not_members_of(cohort)
    Coach.select {|c| !c.cohorts.include?(cohort) }
  end
end
