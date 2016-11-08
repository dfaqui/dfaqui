class Category < ApplicationRecord
  extend FriendlyId
  default_scope { order(:name) }

  belongs_to :segment

  has_many :markets, through: :category_markets
  has_many :category_markets

  has_many :specialities, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :segment, presence: true
  validates :status, presence: true

  friendly_id :name, use: :slugged
end
