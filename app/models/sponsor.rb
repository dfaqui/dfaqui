class Sponsor < ApplicationRecord
  default_scope { order(:order) }

  scope :by_plugin, -> (plugin) do
    includes(customer: [:customer_common]).
    where('customer_commons.plugin': plugin).
    where('sponsors.status')
  end

  mount_uploader :image, SponsorUploader

  belongs_to :customer

  validates :customer, presence: true
  validates :image, presence: true
  validates :order, presence: true, numericality: { only_integer: true }
  validates :status, presence: true
end
