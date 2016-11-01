class Customer < ApplicationRecord
  extend Enumerize
  default_scope { order(:fantasy_name) }

  mount_uploader :logo, CustomerUploader

  scope :by_user_role, -> (user) do
    if user.has_role? :admin
      pluck(:id)
    else
      with_roles([:market, :property], user).pluck(:id)
    end
  end

  scope :properties, -> (user) do
    if user.has_role? :admin
      select(:id, :name).where(plugin: 'property')
    else
      select(:id, :name).where(plugin: 'property').with_role(:property, user)
    end
  end

  scope :markets, -> (user) do
    if user.has_role? :admin
      select(:id, :name).where(plugin: ['delivery', 'market'])
    else
      select(:id, :name).where(plugin: ['delivery', 'market']).
      with_role(:market, user)
    end
  end

  enumerize :plugin, in: [ :market, :property ]
  enumerize :customer_type, in: { person: 1, company: 2 }
  enumerize :status, in: { inactive: 0, active: 1, pending_approval: 2 },
    scope: true, predicates: { prefix: true }

  belongs_to :block

  validates :name, presence: true, length: { maximum: 120 }
  validates :fantasy_name, presence: true, length: { maximum: 120 }
  validates :customer_type, presence: true, numericality: { only_integer: true }
  validates :document, presence: true, length: { maximum: 20 }
  validates :address_complement, length: { maximum: 255 }
  validates :owner_name, presence: true, length: { maximum: 120 }
  validates :owner_email, presence: true, length: { maximum: 100 }
  validates :owner_phone, length: { maximum: 20 }
  validates :contact_email, length: { maximum: 100 }
  validates :additional_info, length: { maximum: 255 }
  validates :plugin, presence: true, length: { maximum: 20 }
  # validates :status, inclusion: { in: [0, 1, 2] }

  resourcify

  def create_advertisement_customer(generated_password)
    self.status       = Customer.status.pending_approval
    self.fantasy_name = self.name

    user              = User.new
    user.name         = self.owner_name
    user.email        = self.owner_email
    user.password     = generated_password

    ActiveRecord::Base.transaction do
      self.save!
      user.save!

      user.add_role self.plugin, self
    end

    rescue ActiveRecord::RecordInvalid => exception
  end

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
