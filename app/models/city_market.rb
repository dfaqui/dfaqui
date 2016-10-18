class CityMarket < ApplicationRecord
  belongs_to :city
  belongs_to :market

  validates :city, presence: true
  validates :market, presence: true

  validates :city, uniqueness: { scope: :market }
end
