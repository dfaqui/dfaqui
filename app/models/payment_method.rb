class PaymentMethod < ApplicationRecord
  validates :icon, presence: true, length: { maximum: 40 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :status, presence: true
end
