class Block < ApplicationRecord
  acts_as_mappable
  default_scope { order(:name) }

  geocoded_by :zipcode
  # after_validation :geocode, if: ->(obj){ obj.zipcode.present? and obj.zipcode_changed? }

  belongs_to :district

  validates :name, presence: true, length: { maximum: 20 }
  validates :district, presence: true
  validates :zipcode, length: { maximum: 9 }
  validates :tour_link, length: { maximum: 255 }
  validates :latitude, numericality: true, allow_nil: true
  validates :longitude, numericality: true, allow_nil: true
  validates :status, presence: true
end
