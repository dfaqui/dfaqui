class Property < ApplicationRecord
  extend Enumerize

  enumerize :property_type, in: { residential: 0, commercial: 1 }
  enumerize :commercial_situation, in: { release: 0, sale: 1, rent: 2 }
  enumerize :release_status, in: { off_plan: 0, under_construction: 1, soon_launching: 2, ready: 3 }

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
  validates :unit, numericality: { only_integer: true }, allow_nil: true
  validates :maintenance_fee, numericality: { only_float: true }, allow_nil: true
  validates :sun_position, length: { maximum: 20 }, allow_nil: true

  def full_address
    "#{self.block.district.name} #{self.block.name}"
  end
end
