class Property < ApplicationRecord
  belongs_to :customer
  belongs_to :block

  has_many :property_images

  validates :customer, presence: true
  validates :block, presence: true
  validates :property_type, presence: true, numericality: { only_integer: true }
  validates :commercial_situation, presence: true, numericality: { only_integer: true }
  validates :release_status, presence: true, numericality: { only_integer: true }
  validates :price, numericality: { only_float: true }, allow_nil: true
  validates :tax, numericality: { only_float: true }, allow_nil: true
  validates :area, presence: true, numericality: { only_integer: true }
  validates :square_meter_price, numericality: { only_float: true }, allow_nil: true
  validates :rooms, presence: true, numericality: { only_integer: true }
  validates :bathrooms, presence: true, numericality: { only_integer: true }
  validates :parking_spaces, presence: true, numericality: { only_integer: true }
  validates :floor, numericality: { only_integer: true }, allow_nil: true
  validates :sun_position, length: { maximum: 20 }, allow_nil: true
end
