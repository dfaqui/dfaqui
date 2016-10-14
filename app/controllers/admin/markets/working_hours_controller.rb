class Admin::Markets::WorkingHoursController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create]
  before_action :set_working_hour, only: [:edit, :update, :destroy]

  def index
    @working_hours = @market.working_hours
  end

  def new
    @working_hour = @market.working_hours.build
  end

  def edit
  end

  def create
    @working_hour = @market.working_hours.new(allowed_params)

    if @working_hour.save
      flash[:notice] = 'Expediente cadastrado com sucesso'
      redirect_to admin_market_working_hours_path(@market.id)
    else
      flash[:error] = 'Erro ao cadastrar expediente'
      render :new
    end
  end

  def update
    if @working_hour.update(allowed_params)
      flash[:notice] = 'Expediente editado com sucesso'
      redirect_to admin_market_working_hours_path(@working_hour.market_id)
    else
      flash[:error] = 'Erro ao editar expediente'
      render :edit
    end
  end

  def destroy
    @working_hour.destroy

    flash[:notice] = 'Expediente removido com sucesso'
    redirect_to admin_market_working_hours_path(@working_hour.market_id)
  end

  private

  def allowed_params
    params.require(:working_hour).permit(
      :opening_time,
      :closing_time,
      days: []
    )
  end

  def set_working_hour
    @working_hour = WorkingHour.find(params[:id])
  end

  def set_market
    @market = Market.find(params[:market_id])
  end
end
