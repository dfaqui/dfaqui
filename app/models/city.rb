class City < ApplicationRecord
  extend FriendlyId
  default_scope { order(:name) }

  belongs_to :state

  has_many :markets, through: :city_markets
  has_many :city_markets

  has_many :district_groups
  has_many :sponsor_buttons
  has_many :sponsor_items

  validates :name, presence: true, length: { maximum: 60 }
  validates :state, presence: true
  validates :status, presence: true

  friendly_id :name, use: :slugged
end
