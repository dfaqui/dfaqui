class Admin::CustomersController < Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
  end

  def new
    @customer = Customer.new
    @customer.plugin = 'market' # Tornar dinâmico
  end

  def edit
  end

  def create
    @customer = Customer.new(allowed_params)
    @customer.contact_phone = params[:contact_phone].select{ |v| !v.empty? }

    if @customer.save
      flash[:notice] = 'Cliente cadastrado com sucesso'
      redirect_to admin_customers_path
    else
      flash[:error] = 'Erro ao cadastrar cliente'
      render :new
    end
  end

  def update
    @customer.contact_phone = params[:contact_phone].select{ |v| !v.empty? }

    if @customer.update(allowed_params)
      flash[:notice] = 'Cliente editada com sucesso'
      redirect_to admin_customers_path
    else
      flash[:error] = 'Erro ao editar cliente'
      render :edit
    end
  end

  def destroy
    @customer.destroy
    flash[:notice] = 'Cliente removido com sucesso'
    redirect_to admin_customers_path
  end

  def add_contact_phone
  end

  private

  def allowed_params
    params.require(:customer).permit(
      :name,
      :fantasy_name,
      :description,
      :logo,
      :block_id,
      :customer_type,
      :document,
      :address_complement,
      :owner_name,
      :owner_email,
      :owner_phone,
      :contact_email,
      :contact_phone,
      :additional_info,
      :plugin
    )
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
