class Block < ApplicationRecord
  belongs_to :district

  validates :name, presence: true, length: { maximum: 20 }
  validates :district, presence: true
  validates :zipcode, length: { maximum: 9 }
  validates :tour_link, length: { maximum: 255 }
  validates :latitude, numericality: true, allow_nil: true
  validates :longitude, numericality: true, allow_nil: true
  validates :status, presence: true
end
