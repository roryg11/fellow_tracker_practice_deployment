class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :cohort

  validate :fellow_has_only_one_membership
  delegate :fellows, :coaches, :staffs, to: :users

  def fellow_has_only_one_membership
    return if user.role != 'Fellow'

    if user.cohorts.length >= 1
      errors.add(:user_id, "Fellow already belongs to a cohort")
    end
  end
end
