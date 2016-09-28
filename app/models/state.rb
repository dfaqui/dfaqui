class State < ApplicationRecord
  validates :name, presence: true, length: { maximum: 60 }
  validates :abbreviation, presence: true, length: { maximum: 2 }
  validates :status, presence: true
end
