class City < ApplicationRecord
  default_scope { order(:name) }

  belongs_to :state
  has_many :district_groups

  validates :name, presence: true, length: { maximum: 60 }
  validates :state, presence: true
  validates :status, presence: true
end
