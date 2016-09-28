class Category < ApplicationRecord
  belongs_to :segment

  validates :name, presence: true, length: { maximum: 100 }
  validates :segment, presence: true
  validates :status, presence: true
end
