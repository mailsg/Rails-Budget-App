require 'rails_helper'

RSpec.describe 'categories page', type: :system do
  include Devise::Test::IntegrationHelpers

  let!(:user1) do
    User.create!(
      name: 'Sandeep Ghosh',
      email: 'mailsg0912@gmail.com    ',
      password: 'pass1234',
      password_confirmation: 'pass1234',
      confirmed_at: Time.now
    )
  end

  let!(:categories) do
    [
      Category.create!(
        user: user1,
        name: 'Rent',
        icon: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVudGFsJTIwcHJvcGVydHl8ZW58MHx8MHx8fDA%3D&w=1000&q=80'
      ),
      Category.create!(
        user: user1,
        name: 'OTT Subscriptions',
        icon: 'https://www.flickonclick.com/wp-content/uploads/2022/07/10-best-OTT-Subscription-plans-in-India-that-are-worth-buying-in-2022.jpg'
      )
    ]
  end

  describe 'show correct categories for user' do
    before(:example) do
      sign_in user1
      visit categories_path
    end

    it 'should have new category link' do
      expect(page).to have_link('New category', href: new_category_path, class: 'link_to newcat')
    end

    it 'should have category details' do
      # expect(page).to have_content(category.name)
      categories.each do |category|
        # Verify icon and name
        expect(page).to have_css("img.icon[src='#{category.icon}']")
        expect(page).to have_css('span.cname', text: category.name)

        # Verify created_at date
        expect(page).to have_css('p', text: category.created_at.to_date.to_s)

        # Verify total_amount
        expect(page).to have_css('p.tamount', text: "$#{category.total_amount}")
      end
    end
  end

  describe 'category link' do
    before(:example) do
      sign_in user1
      visit categories_path
    end

    it 'redirects to the category show page when clicking on the link' do
      @category = categories.first

      find("a[href=\"#{category_path(@category)}\"]").click

      expect(page).to have_current_path(category_path(@category))
    end
  end
end
