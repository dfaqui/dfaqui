class Segment < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :status, presence: true
end
