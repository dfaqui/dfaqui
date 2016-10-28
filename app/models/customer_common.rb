class CustomerCommon < ApplicationRecord
  extend Enumerize
  default_scope { order(:fantasy_name) }

  mount_uploader :logo, CustomerCommonUploader

  enumerize :plugin, in: [ :market, :property ]

  has_many :customers, dependent: :destroy
  accepts_nested_attributes_for :customers

  validates :fantasy_name, presence: true, length: { maximum: 120 }
  validates :plugin, presence: true, length: { maximum: 20 }

  def create_advertisement_customer(generated_password)
    customer          = self.customers.first
    customer.status   = Customer.status.pending_approval.value
    self.fantasy_name = customer.name

    user              = User.new
    user.name         = customer.owner_name
    user.email        = customer.owner_email
    user.password     = generated_password

    ActiveRecord::Base.transaction do
      self.save!
      user.save!

      user.add_role self.plugin, customer
    end

  rescue ActiveRecord::RecordInvalid => exception
  end
end
