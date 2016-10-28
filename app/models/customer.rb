class Customer < ApplicationRecord
  extend Enumerize
  default_scope { order(:name) }

  scope :by_user_role, -> (user) do
    if user.has_role? :admin
      pluck(:id)
    else
      with_roles([:market, :property], user).pluck(:id)
    end
  end

  scope :properties, -> (user) do
    if user.has_role? :admin
      includes(:customer_common).where('customer_commons.plugin': 'property')
    else
      includes(:customer_common).where('customer_commons.plugin': 'property').
      with_role(:property, user)
    end
  end

  scope :markets, -> (user) do
    result = select(:id, :name).
    includes(:customer_common).
    where('customer_commons.plugin': ['delivery', 'market'])

    if user.has_role? :market, :any
      result = result.with_role(:market, user)
    end

    result
  end

  enumerize :customer_type, in: { person: 1, company: 2 }
  enumerize :status, in: { inactive: 0, active: 1, pending_approval: 2 },
    scope: true, predicates: { prefix: true }

  belongs_to :block
  belongs_to :customer_common

  validates :name, presence: true, length: { maximum: 120 }
  # validates :customer_common, presence: true - Impedindo a criação do customer no AdvertisementsController
  validates :customer_type, presence: true, numericality: { only_integer: true }
  validates :document, presence: true, length: { maximum: 20 }
  validates :address_complement, length: { maximum: 255 }
  validates :owner_name, presence: true, length: { maximum: 120 }
  validates :owner_email, presence: true, length: { maximum: 100 }
  validates :owner_phone, length: { maximum: 20 }
  validates :contact_email, length: { maximum: 100 }
  validates :additional_info, length: { maximum: 255 }
  # validates :status, inclusion: { in: [0, 1, 2] }

  resourcify

  def full_address
    template = ''

    if self.block
      template = "%{district} %{block} %{complement} %{city}"

      district    = self.block.district.name
      block       = self.block.name
      complement  = self.address_complement
      city        = self.block.district.district_group.city.name

      template = template % {
        district: district,
        block: "Bloco #{block}",
        complement: complement,
        city: "(#{city})"
      }
    end

    template
  end
end
