class District < ApplicationRecord
  belongs_to :district_group

  validates :name, presence: true, length: { maximum: 100 }
  validates :district_group, presence: true
  validates :status, presence: true
end
