require 'rails_helper'

feature "Users" do

  scenario "Super User can create a fellow" do
    User.create!(
      first_name: "Rory",
      last_name: "Grant",
      email: "rory.c.grant@gmail.com",
      password: "roryrocks",
      admin: true
    )

    visit root_path
    fill_in "Email", with: "rory.c.grant@gmail.com"
    fill_in "Password", with: "roryrocks"
    click_on "Log in"
    click_on "new-user-button"
    save_and_open_page
    fill_in "First name", with: "Tina"
    fill_in "Last name", with: "Loh"
    fill_in "Email", with: "tinalola@gmail.com"
    click_on "submit-user-button"

    expect(page).to have_content("Tina")
    expect(page).to have_content("Loh")
    expect(page).to have_content("tinalola@gmail.com")

  scenario 'Fellow can not see another fellows goals' do
    other_user = User.create!(
      email: 'other-user@example.com',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )
    other_user.goals.create!(description: 'other persons goal')

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
