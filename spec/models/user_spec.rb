require 'rails_helper'

describe User do
  describe '#fellow?' do
    it 'returns true if the user is a fellow' do
      user = Fellow.create!(
        email: 'fellow@uncollege.org',
        password: 'abcd1234',
        password_confirmation: 'abcd1234'
      )

      expect(user.fellow?).to eq(true)
    end

    it 'returns false when the user is not a fellow' do
      user = Staff.create!(
        email: 'admin@uncollege.org',
        password: 'abcd1234',
        password_confirmation: 'abcd1234'
      )

      expect(user.fellow?).to eq(false)
    end
  end

  describe '#full_name' do
    it 'returns the users full name' do
      user = Fellow.create!(
        first_name: 'first',
        last_name: 'last',
        email: 'fellow@uncollege.org',
        password: 'abcd1234',
        password_confirmation: 'abcd1234'
      )

      expect(user.full_name).to eq('first last')
    end
  end
end
