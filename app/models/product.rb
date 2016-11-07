class Product < ApplicationRecord
  mount_uploader :photo, ProductUploader

  belongs_to :market

  validates :name, presence: true, length: { maximum: 60 }
  validates :market, presence: true
  validates :price, numericality: { only_float: true }, allow_blank: true
end
