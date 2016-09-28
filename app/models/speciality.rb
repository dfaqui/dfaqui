class Speciality < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 100 }
  validates :category, presence: true
  validates :status, presence: true
end
