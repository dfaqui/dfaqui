class Admin::MarketsController < Admin::BaseController
  before_action :set_market, only: [:edit, :update, :destroy]
  def index
    @markets = Market.all
  end

  def show
  end

  def new
    @market = Market.new
  end

  def edit
  end

  def create
    @market = Market.new(allowed_params)

    if @market.save
      flash[:notice] = 'Comércio cadastrado com sucesso'
      redirect_to admin_markets_path
    else
      flash[:error] = 'Erro ao cadastrar comércio'
      render :new
    end
  end

  def update
    if @market.update(allowed_params)
      flash[:notice] = 'Comércio editado com sucesso'
      redirect_to admin_markets_path
    else
      flash[:error] = 'Erro ao editar comércio'
      render :edit
    end
  end

  def destroy
    @market.destroy
    flash[:notice] = 'Comércio removido com sucesso'
    redirect_to admin_markets_path
  end

  private

  def allowed_params
    params.require(:market).permit(
      :customer_id,
      :segment_id,
      :price_category,
      :always_open,
      :delivery,
      :only_delivery,
      :estimated_time
    )
  end

  def set_market
    @market = Market.find(params[:id])
  end
end
