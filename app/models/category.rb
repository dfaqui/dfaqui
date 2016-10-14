class Category < ApplicationRecord
  belongs_to :segment

  has_many :markets, through: :category_markets
  has_many :category_markets

  validates :name, presence: true, length: { maximum: 100 }
  validates :segment, presence: true
  validates :status, presence: true
end
