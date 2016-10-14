class CategoryMarket < ApplicationRecord
  belongs_to :category
  belongs_to :market

  validates :category, presence: true
  validates :market, presence: true
  validates :category, uniqueness: { scope: :market }
end
