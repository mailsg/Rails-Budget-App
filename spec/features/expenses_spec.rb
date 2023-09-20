require 'rails_helper'

RSpec.describe 'categories page', type: :system do
  include Devise::Test::IntegrationHelpers

  let!(:user1) do
    User.create!(
      name: 'Sandeep Ghosh',
      email: 'mailsg0912@gmail.com',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      confirmed_at: Time.now
    )
  end

  let!(:category) do
    Category.create!(
      user: user1,
      name: 'Rent',
      icon: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVudGFsJTIwcHJvcGVydHl8ZW58MHx8MHx8fDA%3D&w=1000&q=80'
    )
  end

  let!(:expenses) do
    category.expense.create!([
                               { name: 'home', amount: 12, user: user1 },
                               { name: 'car', amount: 5, user: user1 }
                             ])
  end

  describe 'show correct expenses for a category' do
    before(:example) do
      sign_in user1
      visit category_path(category)
    end
    it 'has total amount' do
      expect(page).to have_content('Total Amount:')
    end
    it 'has back link' do
      expect(page).to have_link('Back to categories', href: categories_path)
    end

    it 'has new expense create link' do
      expect(page).to have_link('New expense', href: new_category_expense_path(category))
    end

    it 'has new destroy category link' do
      expect(page).to have_button('Delete this category', class: 'link_to delete')
    end
    it 'has expenses details' do
      expenses.each do |expense|
        expect(page).to have_content(expense.name)
        expect(page).to have_content(expense.amount)
      end
    end
  end
end
