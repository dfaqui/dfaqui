class Admin::Markets::SpecialitiesController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :destroy]
  before_action :set_category, only: [:index, :new]

  def index
    @specialities = @market.specialities
  end

  def new
    @specialities_dropdown = Speciality.where(category: params[:category_id])
  end

  def create
    speciality = Speciality.find(allowed_params[:id])

    if @market.specialities.append(speciality)
      flash[:notice] = 'Especialidade adicionada com sucesso'
      redirect_to admin_market_category_specialities_path(@market.id, params[:category_id])
    else
      flash[:error] = 'Erro ao adicionar especialidade'
      render :new
    end
  end

  def destroy
    @market.specialities.destroy(params[:id])

    flash[:notice] = 'Especialidade removida com sucesso'
    redirect_to admin_market_category_specialities_path(@market.id, params[:category_id])
  end

  private

  def allowed_params
    params.require(:speciality).permit(:id)
  end

  def set_market
    @market = Market.find(params[:market_id])
  end

  def set_category
    @category = Category.friendly.find(params[:category_id])
  end
end
