class Page < ApplicationRecord
  validates :code, presence: true, length: { maximum: 50 }
  validates :plugin, presence: true, length: { maximum: 20 }
  validates :status, presence: true
end
