require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'validates the presence of a name' do
      user = User.create!(
        name: 'Sandeep Ghosh',
        email: 'mailsg0912@gmail.com',
        password: 'pass1234',
        password_confirmation: 'pass1234',
        confirmed_at: Time.now
      )

      expect(user).to be_valid

      user.name = nil
      expect(user).not_to be_valid
    end
  end

  context 'associations' do
    it 'has many categories' do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many expenses' do
      association = described_class.reflect_on_association(:expense)
      expect(association.macro).to eq(:has_many)
    end
  end
end
