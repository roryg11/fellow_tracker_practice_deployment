require 'rails_helper'
require 'date'

describe Coach do
  it "gives an array of coaches not assigned to a passed in cohort" do
    coach_1 = Coach.create!(
    first_name: "test",
    last_name: "user",
    email: "user@test.com",
    password: "12345678",
    )

    coach_2 = Coach.create!(
    first_name: "test 2",
    last_name: "user",
    email: "user_2@test.com",
    password: "12345678",
    )

    cohort = Cohort.create!(
    season: "Fall",
    year: "2014",
    start_date: Date.today.beginning_of_week
    )

    membership = Membership.create!(
    user_id: coach_1.id,
    cohort_id: cohort.id
    )

    expect(cohort.users).to include(coach_1)
    expect(Coach.not_members_of(cohort)).to eq([coach_2])
  end
end
