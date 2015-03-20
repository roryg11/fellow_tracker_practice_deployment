require 'rails_helper'

describe Goal do
  it "indicates when goal due date is within 2 days" do
    user = User.create!(
      first_name: "rory",
      last_name: "grant",
      email: "rory@gmail.com",
      password: "12345678",
    )

    learn_ruby = Goal.create!(
      description: "learn ruby",
      due_date: 2.days.from_now,
      completed: false
    )

    expect(learn_ruby.due_date_soon?).to eq(true)
  end

  it "returns false when due date is more than 2 days away" do
    user = User.create!(
      first_name: "rory",
      last_name: "grant",
      email: "rory@gmail.com",
      password: "12345678",
    )

    learn_ruby = Goal.create!(
      description: "learn ruby",
      due_date: 3.days.from_now,
      completed: false
    )

    expect(learn_ruby.due_date_soon?).to eq(false)
  end
end
