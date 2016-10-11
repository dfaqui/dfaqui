class Market < ApplicationRecord
  belongs_to :customer
  belongs_to :segment

  validates :customer, presence: true
  validates :segment, presence: true
  validates :price_category, numericality: { only_integer: true }
  validates :always_open, presence: true
  validates :delivery, presence: true
  validates :only_delivery, presence: true
  validates :estimated_time, numericality: { only_integer: true }
  validates :estimated_time_suffix, length: { maximum: 10 }
end
