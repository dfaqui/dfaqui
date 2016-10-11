class DistrictGroup < ApplicationRecord
  default_scope { order(:name) }

  belongs_to :city
  has_many :districts

  validates :name, presence: true, length: { maximum: 60 }
  validates :city, presence: true
  validates :status, presence: true
end
