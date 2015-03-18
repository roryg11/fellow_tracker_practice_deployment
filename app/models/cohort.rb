class Cohort < ActiveRecord::Base
    validates :season, :year, :start_date, presence: true
    validate :start_date_is_a_monday
    has_many :users
    def full_name
        "#{season} #{year}"
    end

    def first_monday
      voyage_phase = 7 * 12
      launch_phase = start_date + voyage_phase
      monday = launch_phase.at_beginning_of_week
    end

    def start_date_is_a_monday
      errors.add(:start_date, "must be a monday") if !start_date.monday?
    end
end
