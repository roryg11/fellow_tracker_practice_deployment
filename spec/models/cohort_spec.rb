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

  it "returns the monday of the week of the Cohort start date" do
    new_cohort = Cohort.create!(
      season: "Spring",
      year: "2015",
      start_date: Date.new(2015, 02, 18)
    )

    expected = Date.new(2015, 02, 16)
    expect(new_cohort.first_monday).to eq(expected)
  end
end
