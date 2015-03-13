class Goal < ActiveRecord::Base
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past
  belongs_to :user

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end
end
