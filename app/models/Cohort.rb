class Cohort < ActiveRecord::Base
    has_many :users
    def name
      @cohorts.each do |cohort|
    "#{cohort.season} #{cohort.year}"
      end
    end
end
