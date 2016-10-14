class Speciality < ApplicationRecord
  default_scope { order(:name) }
  belongs_to :category

  has_many :markets, through: :market_specialities
  has_many :market_specialities

  validates :name, presence: true, length: { maximum: 100 }
  validates :category, presence: true
  validates :status, presence: true
end
