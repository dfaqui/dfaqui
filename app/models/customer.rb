class Customer < ApplicationRecord
  default_scope { order(:name) }

  scope :properties, -> (user) do
    if user.has_role? :admin
      includes(:customer_common).where('customer_commons.plugin': 'property')
    else
      includes(:customer_common).where('customer_commons.plugin': 'property').
      with_role(:property, user)
    end
  end

  scope :markets, -> do
    includes(:customer_common).where('customer_commons.plugin': ['delivery', 'market'])
  end

  extend Enumerize
  enumerize :customer_type, in: { person: 1, company: 2 }

  belongs_to :block
  belongs_to :customer_common

  validates :name, length: { maximum: 120 }
  validates :customer_common, presence: true
  validates :block, presence: true
  validates :customer_type, presence: true, numericality: { only_integer: true }
  validates :document, presence: true, length: { maximum: 20 }
  validates :address_complement, length: { maximum: 255 }
  validates :owner_name, presence: true, length: { maximum: 120 }
  validates :owner_email, presence: true, length: { maximum: 100 }
  validates :owner_phone, length: { maximum: 20 }
  validates :contact_email, presence: true, length: { maximum: 100 }
  validates :additional_info, length: { maximum: 255 }
  validates :status, presence: true

  resourcify

  def full_address
    "#{self.block.district.name} Bloco #{self.block.name} #{self.address_complement}"
  end
end
