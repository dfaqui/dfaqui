class Admin::PropertiesController < Admin::BaseController
  before_action :set_property, only: [:edit, :update, :destroy]

  def index
    if current_user.has_role? :admin
      @properties = Property.all
    else
      allowed_customers = Customer.with_role(:property, current_user).pluck(:id)
      @properties = Property.where(customer: allowed_customers)
    end
  end

  def show
  end

  def new
    @property = Property.new
  end

  def edit
  end

  def create
    @property = Property.new(allowed_params)

    if @property.save
      flash[:notice] = 'Imóvel cadastrado com sucesso'
      redirect_to admin_properties_path
    else
      flash[:error] = 'Erro ao cadastrar imóvel'
      render :new
    end
  end

  def update
    if @property.update(allowed_params)
      flash[:notice] = 'Imóvel editado com sucesso'
      redirect_to admin_properties_path
    else
      flash[:error] = 'Erro ao editar imóvel'
      render :edit
    end
  end

  def destroy
    @property.destroy
    flash[:notice] = 'Imóvel removido com sucesso'
    redirect_to admin_properties_path
  end

  private

  def allowed_params
    params.require(:property).permit(
      :customer_id,
      :block_id,
      :address_complement,
      :property_type,
      :commercial_situation,
      :release_status,
      :description,
      :price,
      :tax,
      :area,
      :rooms,
      :bathrooms,
      :parking_spaces,
      :floor,
      :unit,
      :maintenance_fee,
      :sun_position,
      :status,
      tag_ids: []
    )
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
