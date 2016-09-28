class City < ApplicationRecord
  belongs_to :state

  validates :name, presence: true, length: { maximum: 60 }
  validates :state, presence: true
  validates :status, presence: true
end
