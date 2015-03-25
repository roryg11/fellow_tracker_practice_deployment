class Coach < User
  has_many :mentorships
  has_many :cohorts, through: :memberships

  def full_name
    "#{first_name} #{last_name}"
  end
end
