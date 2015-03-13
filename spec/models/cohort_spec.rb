require 'rails_helper'
require 'date'

RSpec.describe Cohort, :type => :model do
  it "validates that a Cohort has a season, year, start_date" do
    new_cohort = Cohort.create!(
      season: "Fall",
      year: "2015",
      start_date: Date.today
    )

    expect(Cohort.all.length).to eq(1)
    expect(new_cohort.season).to eq("Fall")
    expect(new_cohort.year).to eq("2015")
    expect(new_cohort.start_date).to eq(Date.today)
  end
end
