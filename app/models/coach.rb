class Coach < User
  has_many :mentorships

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.not_members_of(cohort)
    # Coach
    #   .joins(:memberships)
    #   .where.not('users.id IN memberships.cohort_id')
    #   .tap { |q| puts q.to_sql }
  end
end
