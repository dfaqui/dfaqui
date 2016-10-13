class CustomerCommon < ApplicationRecord
  default_scope { order(:fantasy_name) }

  extend Enumerize
  mount_uploader :logo, CustomerCommonUploader

  enumerize :plugin, in: [ :delivery, :market, :property ]

  validates :fantasy_name, presence: true, length: { maximum: 120 }
  validates :plugin, presence: true, length: { maximum: 20 }
  validates :status, presence: true
end
