class Property < ApplicationRecord
  extend Enumerize

  before_save :square_meter_price_calculate

  enumerize :property_type, in: { residential: 0, commercial: 1 }, scope: true
  enumerize :commercial_situation, in: { release: 0, sale: 1, rent: 2 }, scope: true
  enumerize :release_status, in: { off_plan: 0, under_construction: 1, soon_launching: 2, ready: 3 }
  enumerize :sun_position, in: { sunrise: 0, sunset: 1 }

  scope :active, -> do
    where(customer: Customer.with_status(:active).pluck(:id))
  end

  scope :cliente, -> cliente do
    customers = Customer.where(customer_common_id: cliente).pluck(:id)
    where(customer_id: customers)
  end

  scope :tipo, -> tipo { with_property_type(tipo) }
  scope :situacao, -> situacao { with_commercial_situation(situacao) }

  scope :quartos, -> quartos do
    init_value = quartos.split('_')[0]
    limit_value = quartos.split('_')[1]

    if limit_value
      where(rooms: init_value..limit_value)
    else
      where(rooms: init_value)
    end
  end

  scope :area, -> area do
    init_value = area.split('_')[0]
    limit_value = area.split('_')[1]

    if limit_value
      where(area: init_value..limit_value)
    else
      where(area: init_value)
    end
  end

  scope :cidade, -> slug do
    city = City.select(:id).friendly.find(slug)

    includes(block: [district: [:district_group]]).
    where('district_groups.city_id': city)
  end

  scope :quadras, -> slug do
    group = DistrictGroup.select(:id).friendly.find(slug)
    includes(block: [:district]).where('districts.district_group_id': group)
  end

  scope :quadra, -> slug do
    district =  District.select(:id).friendly.find(slug)
    includes(:block).where('blocks.district_id': district)
  end

  scope :bloco, -> (bloco) do
    where(block_id: bloco)
  end

  scope :cep, -> (zipcode) do
    range = 1
    near_blocks = Block.near(zipcode, range).to_a
    where(block_id: near_blocks)
  end

  belongs_to :customer
  belongs_to :block

  has_many :favorites, as: :favoritable
  has_many :messages, as: :messageable

  has_many :property_images, dependent: :destroy

  has_many :tags, through: :property_tags
  has_many :property_tags, dependent: :destroy

  has_one :sponsor, class_name: 'SponsorItem', as: :sponsorable, dependent: :destroy

  accepts_nested_attributes_for :tags

  validates :customer, presence: true
  validates :block, presence: true
  validates :address_complement, length: { maximum: 255 }
  # validates :property_type, presence: true, numericality: { only_integer: true }
  # validates :commercial_situation, presence: true, numericality: { only_integer: true }
  # validates :release_status, presence: true, numericality: { only_integer: true }
  validates :price, numericality: { only_float: true }, allow_nil: true
  validates :tax, numericality: { only_float: true }, allow_nil: true
  validates :area, presence: true, numericality: { only_integer: true }
  validates :square_meter_price, numericality: { only_float: true }, allow_nil: true
  validates :rooms, presence: true, numericality: { only_integer: true }
  validates :bathrooms, presence: true, numericality: { only_integer: true }
  validates :parking_spaces, numericality: { only_integer: true }, allow_nil: true
  validates :floor, length: { maximum: 45 }
  validates :unit, numericality: { only_integer: true }, allow_nil: true
  validates :maintenance_fee, numericality: { only_float: true }, allow_nil: true
  validates :sun_position, numericality: { only_integer: true }, allow_blank: true

  def full_address
    "#{self.block.district.name} #{self.block.name}"
  end

  def cover_image
    if self.property_images.any?
      self.property_images.first.image
    else
      'default_item.png'
    end
  end

  private

  def square_meter_price_calculate
    is_area_present   = !(self.area.nil? || self.area.zero?)
    is_price_present  = !(self.price.nil? || self.price.zero?)

    if self.commercial_situation.rent? || !is_area_present || !is_price_present
      self.square_meter_price = nil
    else
      self.square_meter_price = self.price / self.area
    end

    self.square_meter_price
  end
end
