class Segment < ApplicationRecord
  extend FriendlyId

  validates :name, presence: true, length: { maximum: 100 }
  validates :status, presence: true

  friendly_id :name, use: :slugged
end
