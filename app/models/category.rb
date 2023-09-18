class Category < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :expense, join_table: 'expense_categories', dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :icon, presence: true

    def total_amount
        expense.sum(:amount)
    end
end
