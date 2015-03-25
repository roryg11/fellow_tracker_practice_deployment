require 'rails_helper'

describe Membership do
  it "validates that a fellow can only be a part of one cohort" do
    fellow = Fellow.create!(
      first_name: "fellow",
      last_name: "one",
      email: "fellow@uncollege.org",
      password: "12345678"
    )

    cohort = Cohort.create!(
      season: "Spring",
      start_date: Date.today.beginning_of_week,
      year: "2015"
    )

    cohort_2 = Cohort.create!(
      season: "Fall",
      start_date: (Date.today + 2).beginning_of_week,
      year: "2015"
    )

    membership = Membership.create!(
      cohort_id: cohort.id,
      user_id: fellow.id
    )

    membership_2 = Membership.create(
      cohort_id: cohort_2.id,
      user_id: fellow.id
    )

    expect(fellow.memberships.length).to eq(1)

    expect(membership_2.valid?).to eq(false)
    expect(membership_2.errors.has_key?(:user_id)).to eq(true)
  end
end
