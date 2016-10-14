class MarketSpeciality < ApplicationRecord
  belongs_to :market
  belongs_to :speciality

  validates :market, presence: true
  validates :speciality, presence: true
  validates :speciality, uniqueness: { scope: :market }
end
