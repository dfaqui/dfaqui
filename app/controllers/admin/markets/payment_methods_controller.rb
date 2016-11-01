class Admin::Markets::PaymentMethodsController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :destroy]

  def index
  end

  def new
    @payment_methods = PaymentMethod.where.not(id: @market.payment_methods)
  end

  def create
    @market.payment_methods.push(PaymentMethod.find(allowed_params))
    redirect_to admin_market_payment_methods_path(@market.id)
  end

  def destroy
    @market.payment_methods.destroy(params[:id])
    redirect_to admin_market_payment_methods_path(@market.id)
  end

  private

  def allowed_params
    params.require(:payment_method).permit(:id)[:id]
  end

  def set_market
    @market = Market.find(params[:market_id])
  end
end
