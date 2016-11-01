class Admin::Markets::CategoriesController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :destroy]

  def index
  end

  def new
    @categories = @market.segment.categories.where.not(id: @market.categories)
  end

  def create
    @market.categories.push(Category.find(allowed_params))
    redirect_to admin_market_categories_path(@market.id)
  end

  def destroy
    specialities_to_delete = @market.specialities.where(category_id: params[:id])
    @market.specialities.destroy(specialities_to_delete)

    @market.categories.destroy(params[:id])
    redirect_to admin_market_categories_path(@market.id)
  end

  private

  def allowed_params
    params.require(:category).permit(:id)[:id]
  end

  def set_market
    @market = Market.find(params[:market_id])
  end
end
