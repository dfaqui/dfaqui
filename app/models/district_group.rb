class DistrictGroup < ApplicationRecord
  belongs_to :city

  validates :name, presence: true, length: { maximum: 60 }
  validates :city, presence: true
  validates :status, presence: true
end
