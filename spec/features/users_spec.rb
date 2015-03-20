require 'rails_helper'

feature "Users" do
  scenario "Staff can create a fellow" do
    User.create!(
      first_name: "Rory",
      last_name: "Grant",
      email: "rory.c.grant@gmail.com",
      password: "roryrocks",
      role: "Staff"
    )

    Cohort.create!(
      season: "Fall",
      year: "2015",
      start_date: Date.new(2015, 04, 20)
      )

    visit root_path
    click_on "Login"
    fill_in "Email", with: "rory.c.grant@gmail.com"
    fill_in "Password", with: "roryrocks"
    click_on "Log in"
    visit root_path
    click_on 'new-fellow-button'
    fill_in "First name", with: "Tina"
    fill_in "Last name", with: "Loh"
    fill_in "Email", with: "tinalola@gmail.com"
    click_on "submit-user-button"

    expect(page).to have_content("Tina")
    expect(page).to have_content("Loh")
    expect(page).to have_content("tinalola@gmail.com")
  end

  scenario 'Fellow can add a goal' do
    User.create!(
      email: 'user@example.com',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )

    visit root_path
    click_on "Login"
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: "abcd1234"
    click_on "Log in"
    click_on 'Dashboard'
    click_on 'new-goal-action'
    fill_in 'goal_description', with: 'goal description'
    fill_in 'goal_due_date', with: '2015-03-25'
    click_on 'save-goal-action'

    expect(page).to have_content('goal description')
    expect(page).to have_content('2015-03-25')
  end

  xscenario 'Fellow can not see another fellows goals' do
    other_user = User.create!(
      email: 'other-user@example.com',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )
    other_user.goals.create!(description: 'other persons goal', due_date: '2015-03-29')

    User.create!(
      email: 'user@example.com',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )

    visit root_path
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: "abcd1234"
    click_on "Log in"

    expect(page).to_not have_content('other persons goal')
  end
end
