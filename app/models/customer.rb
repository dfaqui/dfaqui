class Customer < ApplicationRecord
  extend Enumerize

  default_scope { order(:fantasy_name) }

  enumerize :plugin, in: [ :market, :property ]
  enumerize :customer_type, in: { person: 1, company: 2 }
  enumerize :status, in: { inactive: 0, active: 1, pending_approval: 2 },
    scope: true, predicates: { prefix: true }

  scope :by_user_role, -> (user) do
    if user.has_role? :admin
      all()
    else
      with_roles([:market, :property], user)
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

  belongs_to :block

  validates :name, presence: true, length: { maximum: 120 }
  validates :fantasy_name, presence: true, length: { maximum: 120 }
  validates :customer_type, presence: true, numericality: { only_integer: true }
  validates :document, length: { maximum: 20 }, cpf_or_cnpj: true
  validates :address_complement, length: { maximum: 255 }
  validates :owner_name, presence: true, length: { maximum: 120 }
  validates :owner_email, length: { maximum: 100 }, email: true
  validates :owner_phone, length: { maximum: 20 }
  validates :contact_email, length: { maximum: 100 }, allow_blank: true, email: true
  validates :additional_info, length: { maximum: 255 }
  validates :plugin, presence: true, length: { maximum: 20 }
  # validates :status, inclusion: { in: [0, 1, 2] }

  mount_uploader :logo, CustomerUploader
  resourcify

  before_destroy :destroy_market, if: -> (obj) { obj.plugin.market? }
  before_destroy :destroy_properties, if: -> (obj) { obj.plugin.property? }

  def create_advertisement_customer(generated_password)
    self.status       = Customer.status.pending_approval
    self.fantasy_name = self.name

    ActiveRecord::Base.transaction do
      self.save!

      is_new_user   = 0
      user          = User.where(email: self.owner_email).first

      if user.nil?
        user = User.new(
          name: self.owner_name,
          email: self.owner_email,
          password: generated_password
        )

        is_new_user   = 1
        user.save!
      end

      user.add_role self.plugin, self

      is_new_user
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

  def contact_phone_as_string
    self.contact_phone.join(', ')
  end

  private

  def destroy_market
    Market.destroy_all(customer: self)
  end

  def destroy_properties
    Property.destroy_all(customer: self)
  end
end
