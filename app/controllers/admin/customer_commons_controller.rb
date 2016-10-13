class Admin::CustomerCommonsController < Admin::BaseController
  before_action :set_customer_common, only: [:show, :edit, :update, :destroy]

  def index
    @customers = CustomerCommon.all
  end

  def show
  end

  def new
    @customer = CustomerCommon.new
  end

  def edit
  end

  def create
    @customer = CustomerCommon.new(allowed_params)

    if @customer.save
      flash[:notice] = 'Cliente cadastrado com sucesso'
      redirect_to admin_customer_commons_path
    else
      flash[:error] = 'Erro ao cadastrar cliente'
      render :new
    end
  end

  def update
    if @customer.update(allowed_params)
      flash[:notice] = 'Cliente editado com sucesso'
      redirect_to admin_customer_commons_path
    else
      flash[:error] = 'Erro ao editar cliente'
      render :new
    end
  end

  def destroy
    @customer.destroy
    flash[:notice] = 'Cliente removido com sucesso'
    redirect_to admin_customer_commons_path
  end

  private

  def allowed_params
    params.require(:customer_common).permit(
      :fantasy_name,
      :plugin,
      :logo,
      :description
    )
  end

  def set_customer_common
    @customer = CustomerCommon.find(params[:id])
  end
end
