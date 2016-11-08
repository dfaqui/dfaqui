class Segment < ApplicationRecord
  extend FriendlyId
  default_scope { order(:name) }

  has_many :categories, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :status, presence: true

  friendly_id :name, use: :slugged
end
