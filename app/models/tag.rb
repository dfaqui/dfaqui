class Tag < ApplicationRecord
  default_scope { order(:name) }

  has_many :properties, through: :property_tags
  has_many :property_tags

  validates :name, presence: true, length: { maximum: 100 }
  validates :plugin, presence: true, length: { maximum: 20 }
  validates :status, presence: true
end
