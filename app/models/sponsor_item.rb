class SponsorItem < ApplicationRecord
  default_scope { order(:order) }

  scope :by_city, -> (slug) do
    city = (slug.nil?) ? City.first : City.select(:id).friendly.find(slug)
    where(city: city)
  end

  belongs_to :city
  belongs_to :sponsorable, polymorphic: true

  validates :city, presence: true
  validates :order, presence: true, numericality: { only_integer: true }
  validates :status, presence: true
end
