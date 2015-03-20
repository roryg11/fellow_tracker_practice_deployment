require 'rails_helper'

feature 'fellow goal tracking' do
  scenario 'a fellow can create a goal' do
    Fellow.create!(
      email: 'fellow@uncollege.org',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )

    visit root_path
    click_on "Login"
    fill_in "Email", with: 'fellow@uncollege.org'
    fill_in "Password", with: "abcd1234"
    click_on "Log in"

    click_on 'new-goal-action'
    fill_in 'goal_description', with: 'goal description'
    fill_in 'goal_due_date', with: (Date.today + 2)
    click_on 'save-goal-action'

    expect(page).to have_content('goal description')
    expect(page).to have_content("#{Date.today + 2}")
  end

  scenario 'a fellow can mark a goal as completed' do
    fellow = Fellow.create!(
      email: 'fellow@uncollege.org',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )

    Goal.create!(
      user: fellow,
      description: 'goal description',
      due_date: Date.tomorrow
    )

    visit root_path
    click_on "Login"
    fill_in "Email", with: 'fellow@uncollege.org'
    fill_in "Password", with: "abcd1234"
    click_on "Log in"

    within('tbody tr:text("goal description")') do
      expect(page).to_not have_content('completed')
      page.find('.complete-goal-action').click
    end


    within('tbody tr:text("goal description")') do
      page.find('.done')
    end
  end
end
