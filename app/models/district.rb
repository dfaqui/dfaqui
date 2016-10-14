class District < ApplicationRecord
  extend FriendlyId
  default_scope { order(:name) }

  belongs_to :district_group
  has_many :blocks

  validates :name, presence: true, length: { maximum: 100 }
  validates :district_group, presence: true
  validates :status, presence: true

  friendly_id :name, use: :slugged
end
