class Admin::Markets::CitiesController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :destroy]

  def index
    @cities = @market.cities
  end

  def new
  end

  def create
    city = City.find(allowed_params[:id])

    if @market.cities.append(city)
      flash[:notice] = 'Local de entrega adicionado com sucesso'
      redirect_to admin_market_cities_path(@market.id)
    else
      flash[:error] = 'Erro ao adicionar local de entrega'
      render :new
    end
  end

  def destroy
    @market.cities.destroy(params[:id])

    flash[:notice] = 'Local de entrega removido com sucesso'
    redirect_to admin_market_cities_path(@market.id)
  end

  private

  def allowed_params
    params.require(:city).permit(:id)
  end

  def set_market
    @market = Market.find(params[:market_id])
  end
end
