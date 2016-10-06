class CustomerCommon < ApplicationRecord
  mount_uploader :logo, CustomerCommonUploader

  validates :fantasy_name, presence: true, length: { maximum: 120 }
  validates :plugin, presence: true, length: { maximum: 20 }
  validates :status, presence: true
end
