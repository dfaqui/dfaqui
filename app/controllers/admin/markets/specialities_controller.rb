class Admin::Markets::SpecialitiesController < Admin::BaseController
  before_action :set_market, only: [:new, :create, :destroy]

  def new
    category      = Category.find(params[:category_id])
    @specialities = category.specialities.where.not(id: @market.specialities)
  end

  def create
    @market.specialities.push(Speciality.find(allowed_params))
    redirect_to admin_market_categories_path(@market.id)
  end

  def destroy
    @market.specialities.destroy(params[:id])
    redirect_to admin_market_categories_path(@market.id)
  end

  private

  def set_market
    @market = Market.find(params[:market_id])
  end

  def allowed_params
    params.require(:speciality).permit(:id)[:id]
  end
end
