class SponsorButton < ApplicationRecord
  extend Enumerize
  default_scope { order(:order) }

  enumerize :channel, in: { delivery: :delivery, market: :market, property: :property }, scope: true

  scope :by_city, -> (slug) do
    city = (slug.nil?) ? City.first : City.select(:id).friendly.find(slug)
    where(city: city)
  end

  mount_uploader :image, SponsorButtonUploader

  belongs_to :customer
  belongs_to :city

  validates :customer, presence: true
  validates :city, presence: true
  validates :channel, presence: true, length: { maximum: 10 }
  validates :image, presence: true
  validates :order, presence: true, numericality: { only_integer: true }
  validates :status, presence: true
end
