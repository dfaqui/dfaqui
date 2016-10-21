class User < ApplicationRecord
  extend Enumerize
  default_scope { order(:name) }

  enumerize :role, in: { admin: :admin, regular: :regular, property: :property }

  has_many :favorites

  validates :name, presence: true, length: { maximum: 100 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :omniauthable

  rolify

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
