class PaymentMethod < ApplicationRecord
  default_scope { order(:name) }

  validates :icon, presence: true, length: { maximum: 40 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :status, presence: true
end
