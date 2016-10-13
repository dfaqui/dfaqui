class Admin::Markets::PaymentMethodsController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :destroy]

  def index
    @payment_methods = @market.payment_methods
  end

  def new
  end

  def create
    payment_method = PaymentMethod.find(allowed_params[:id])

    if @market.payment_methods.append(payment_method)
      flash[:notice] = 'Forma de pagamento adicionada com sucesso'
      redirect_to admin_market_payment_methods_path(@market.id)
    else
      flash[:error] = 'Erro ao adicionar forma de pagamento'
      render :new
    end
  end

  def destroy
    @market.payment_methods.destroy(params[:id])

    flash[:notice] = 'Forma de pagamento removida com sucesso'
    redirect_to admin_market_payment_methods_path(@market.id)
  end

  private

  def allowed_params
    params.require(:payment_method).permit(:id)
  end

  def set_market
    @market = Market.find(params[:market_id])
  end
end
