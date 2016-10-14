class Market < ApplicationRecord
  belongs_to :customer
  belongs_to :segment

  has_many :products

  has_many :categories, through: :category_markets
  has_many :category_markets

  has_many :payment_methods, through: :market_payment_methods
  has_many :market_payment_methods

  validates :customer, presence: true
  validates :segment, presence: true
  validates :price_category, numericality: { only_integer: true }
  validates :always_open, presence: true
  validates :delivery, presence: true
  validates :only_delivery, presence: true
  validates :estimated_time, numericality: { only_integer: true }
  validates :estimated_time_suffix, length: { maximum: 10 }
end
