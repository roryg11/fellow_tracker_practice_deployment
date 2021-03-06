class Goal < ActiveRecord::Base
  validates :due_date, :description, presence: true
  validate :due_date_cannot_be_in_the_past, on: :create
  belongs_to :user

  def self.for_week(cohort, week_number)
    where(due_date: cohort.week_start_date(week_number)..cohort.week_end_date(week_number))
  end

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def due_date_soon?
    (due_date - Date.today).to_i < 3
  end

  def overdue?
    (due_date - Date.today).to_i <= 0
  end

  def created_within_two_hours?
    (created_at - DateTime.now).abs < 2.hours
  end

  def format_due_date
    due_date.strftime("%B %d, %Y")
  end
end
