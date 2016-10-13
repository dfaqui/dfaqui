class MarketPaymentMethod < ApplicationRecord
  belongs_to :market
  belongs_to :payment_method

  validates :market, presence: true
  validates :payment_method, presence: true
  validates :payment_method, uniqueness: { scope: :market }
end
