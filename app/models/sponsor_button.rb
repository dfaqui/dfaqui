class SponsorButton < ApplicationRecord
  default_scope { order(:order) }

  scope :by_plugin, -> (plugin) do
    includes(customer: [:customer_common]).
    where('customer_commons.plugin': plugin).
    where('sponsor_buttons.status')
  end

  mount_uploader :image, SponsorButtonUploader

  belongs_to :customer

  validates :customer, presence: true
  validates :image, presence: true
  validates :order, presence: true, numericality: { only_integer: true }
  validates :status, presence: true
end
