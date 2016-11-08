class Product < ApplicationRecord
  mount_uploader :photo, ProductUploader

  belongs_to :market

  validates :name, presence: true, length: { maximum: 60 }
  validates :market, presence: true
  # validates :price, numericality: { only_integer: true }, allow_blank: true

  monetize :price, as: :price_cents, allow_nil: true

  before_validation :price_to_cents

  private

  def price_to_cents
    if self.price_cents
      self.price_cents = Money.new(price_cents)
    end
  end
end
