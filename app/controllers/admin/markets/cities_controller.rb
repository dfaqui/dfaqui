class Admin::Markets::CitiesController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :destroy]

  def index
  end

  def new
    @cities = City.where.not(id: @market.cities)
  end

  def create
    @market.cities.push(City.find(allowed_params))
    redirect_to admin_customer_market_cities_path(@market.customer_id, @market.id)
  end

  def destroy
    @market.cities.destroy(params[:id])
    redirect_to admin_customer_market_cities_path(@market.customer_id, @market.id)
  end

  private

  def allowed_params
    params.require(:city).permit(:id)[:id]
  end

  def set_market
    @market = Market.find(params[:market_id])
  end
end
