class Cohort < ActiveRecord::Base
    validates :season, :year, :start_date, presence: true
    has_many :users
    def full_name
        "#{season} #{year}"
    end
    def first_monday
      monday = start_date.at_beginning_of_week
    end
end
