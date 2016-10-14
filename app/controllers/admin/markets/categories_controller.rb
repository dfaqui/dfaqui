class Admin::Markets::CategoriesController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :destroy]

  def index
    @categories = @market.categories
  end

  def new
    @categories_dropdown = Category.where(segment: @market.segment)
  end

  def create
    category = Category.find(allowed_params[:id])

    if @market.categories.append(category)
      flash[:notice] = 'Tipo adicionado com sucesso'
      redirect_to admin_market_categories_path(@market.id)
    else
      flash[:error] = 'Erro ao adicionar tipo'
      render :new
    end
  end

  def destroy
    @market.categories.destroy(params[:id])

    flash[:notice] = 'Tipo removido com sucesso'
    redirect_to admin_market_categories_path(@market.id)
  end

  private

  def allowed_params
    params.require(:category).permit(:id)
  end

  def set_market
    @market = Market.find(params[:market_id])
  end
end
