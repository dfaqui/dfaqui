class Page < ApplicationRecord
  validates :code, presence: true, length: { maximum: 50 }
  validates :value, presence: true
  validates :condition, length: { maximum: 100 }
  validates :status, presence: true
end
