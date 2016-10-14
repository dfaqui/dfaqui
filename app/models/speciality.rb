class Speciality < ApplicationRecord
  extend FriendlyId
  default_scope { order(:name) }

  belongs_to :category

  has_many :markets, through: :market_specialities
  has_many :market_specialities

  validates :name, presence: true, length: { maximum: 100 }
  validates :category, presence: true
  validates :status, presence: true

  friendly_id :name, use: :slugged
end
