class Admin::CustomersController < Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_customer_common, only: [:index, :new, :create, :destroy]

  def index
    @customers = @customer_common.customers
  end

  def show
  end

  def new
    @customer = @customer_common.customers.build
  end

  def edit
  end

  def create
    @customer = @customer_common.customers.new(allowed_params)
    @customer.block_id = 3

    if @customer.save
      flash[:notice] = 'Filial cadastrada com sucesso'
      redirect_to admin_customer_common_customers_path(@customer_common.id)
    else
      flash[:error] = 'Erro ao cadastrar filial'
      render :new
    end
  end

  def update
    if @customer.update(allowed_params)
      flash[:notice] = 'Filial editada com sucesso'
      redirect_to admin_customer_common_customers_path(@customer.customer_common_id)
    else
      flash[:error] = 'Erro ao editar filial'
      render :edit
    end
  end

  def destroy
    @customer_common.customers.destroy(params[:id])

    flash[:notice] = 'Filial removida com sucesso'
    redirect_to admin_customer_common_customers_path(@customer_common.id)
  end

  def add_contact_phone
  end

  private

  def allowed_params
    params.require(:customer).permit(
      :name,
      :customer_type,
      :document,
      :owner_name,
      :owner_email,
      :owner_phone,
      :contact_email,
      :contact_phone
    )
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_customer_common
    @customer_common = CustomerCommon.find(params[:customer_common_id])
  end
end
