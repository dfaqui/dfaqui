class Market < ApplicationRecord
  scope :by_role, -> (user) do
    allowed_customers = Customer.markets(user).pluck(:id)
    Market.where(customer: allowed_customers)
  end

  scope :active, -> do
    where(customer: Customer.with_status(:active).pluck(:id))
  end

  scope :by_channel, -> channel do
    if channel == 'comercio'
      where(only_delivery: false)
    elsif channel == 'delivery'
      where(delivery: true)
    end
  end

  scope :cliente, -> cliente do
    customers = Customer.where(customer_common_id: cliente).pluck(:id)
    where(customer_id: customers)
  end

  scope :cidade, -> slug do
    city = City.select(:id).friendly.find(slug)

    includes(customer: [block: [district: [:district_group]]]).
    where('district_groups.city_id': city)
  end

  scope :quadras, -> slug do
    group = DistrictGroup.select(:id).friendly.find(slug)
    includes(customer: [block: [:district]]).where('districts.district_group_id': group)
  end

  scope :quadra, -> slug do
    district =  District.select(:id).friendly.find(slug)
    includes(customer: [:block]).where('blocks.district_id': district)
  end

  scope :segmento, -> slug { where(segment: Segment.select(:id).friendly.find(slug)) }

  scope :categoria, -> slug do
    category = Category.select(:id).friendly.find(slug)
    includes(:category_markets).where('category_markets.category_id': category)
  end

  scope :especialidade, -> slug do
    speciality = Speciality.select(:id).friendly.find(slug)
    includes(:market_specialities).where('market_specialities.speciality_id': speciality)
  end

  scope :cep, -> (zipcode) do
    range = 1
    near_blocks = Block.near(zipcode, range).to_a
    includes(:customer).where('customers.block_id': near_blocks)
  end

  belongs_to :customer
  belongs_to :segment

  has_many :cities, through: :city_markets, dependent: :destroy
  has_many :city_markets

  has_many :favorites, as: :favoritable

  has_many :products, -> { order(:name) }, dependent: :destroy

  has_many :categories, through: :category_markets, dependent: :destroy
  has_many :category_markets

  has_many :payment_methods, through: :market_payment_methods, dependent: :destroy
  has_many :market_payment_methods

  has_many :specialities, through: :market_specialities, dependent: :destroy
  has_many :market_specialities

  has_many :working_hours, dependent: :destroy

  validates :customer, presence: true
  validates :segment, presence: true
  validates :price_category, numericality: { only_integer: true }, allow_nil: true
  validates :always_open, inclusion: [true, false]
  validates :delivery, inclusion: [true, false]
  validates :only_delivery, inclusion: [true, false]
  validates :estimated_time, numericality: { only_integer: true }, allow_nil: true
  validates :estimated_time_suffix, length: { maximum: 10 }

  def is_open?
    return true if self.always_open?

    now = Time.zone.now
    now_time = now.strftime('%H:%M')

     working_hours  = self.
                      working_hours.
                      where("'#{now.wday}' = ANY(days)").
                      where("'#{now_time}' BETWEEN opening_time AND closing_time").
                       pluck(:opening_time, :closing_time).first

     if working_hours
       {
         opening_time: working_hours[0].strftime('%H:%M'),
         closing_time: working_hours[1].strftime('%H:%M')
       }
     end
  end
end
