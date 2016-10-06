class PropertyImage < ApplicationRecord
  default_scope { order(:order) }

  mount_uploader :image, PropertyUploader

  belongs_to :property

  validates :property, presence: true
  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :order, presence: true, numericality: { only_integer: true }
  validates :status, presence: true
end
