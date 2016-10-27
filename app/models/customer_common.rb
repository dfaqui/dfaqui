class CustomerCommon < ApplicationRecord
  extend Enumerize
  default_scope { order(:fantasy_name) }

  mount_uploader :logo, CustomerCommonUploader

  enumerize :plugin, in: [ :market, :property ]

  has_many :customers, dependent: :destroy
  accepts_nested_attributes_for :customers

  validates :fantasy_name, presence: true, length: { maximum: 120 }
  validates :plugin, presence: true, length: { maximum: 20 }
end
