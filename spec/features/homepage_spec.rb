require 'rails_helper'

describe 'The homepage' do
  it 'has a blurb about Fellow Tracker' do
    visit root_path

    expect(page).to have_content('Fellow Tracker')
    expect(page).to have_content('A simple app to help you track your goals')
    expect(page).to have_content('Login')
  end
end
