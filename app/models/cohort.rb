class Cohort < ActiveRecord::Base
    validates :season, :year, :start_date, presence: true
    has_many :users
end
