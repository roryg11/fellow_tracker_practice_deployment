require 'rails_helper'

feature "Users" do
  scenario "Staff can create a fellow" do
    Staff.create!(
      first_name: "Rory",
      last_name: "Grant",
      email: "rory.c.grant@gmail.com",
      password: "roryrocks",
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

    click_on 'show-fellows-action'
    click_on 'new-fellow-action'
    fill_in "First name", with: "Tina"
    fill_in "Last name", with: "Loh"
    fill_in "Email", with: "tinalola@gmail.com"
    click_on "submit-user-button"

    expect(page).to have_content("Tina")
    expect(page).to have_content("Loh")
    expect(page).to have_content("tinalola@gmail.com")
  end
end
