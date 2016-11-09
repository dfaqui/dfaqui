class Admin::PropertiesController < Admin::BaseController
  before_action :set_property, only: [:edit, :update, :destroy]
  before_action :select_tags, only: [:new, :edit]

  def index
    if current_user.has_role? :admin
      @properties = Property.includes(:customer, block: [district: [district_group: [:city]]]).all
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
    property_params = allowed_params

    tags      = (property_params.delete :tag_ids)
    @property = Property.new(property_params)

    if @property.save
      if tags
        tags = tags.collect{|v| Tag.find(v.to_i)}
        @property.tags << tags
      end

      flash[:notice] = 'Imóvel cadastrado com sucesso'
      redirect_to admin_properties_path
    else
      # O callback que seleciona as tags não está sendo disparado quando a
      # validação do formulário não passa. Por isso, a necessidade de chamar o
      # método aqui
      select_tags

      flash[:error] = 'Erro ao cadastrar imóvel'
      render :new
    end
  end

  def update
    if @property.update(allowed_params)
      flash[:notice] = 'Imóvel editado com sucesso'
      redirect_to admin_properties_path
    else
      # O callback que seleciona as tags não está sendo disparado quando a
      # validação do formulário não passa. Por isso, a necessidade de chamar o
      # método aqui
      select_tags

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
      :price_cents,
      :tax_cents,
      :area,
      :rooms,
      :suites,
      :bathrooms,
      :parking_spaces,
      :floor,
      :unit,
      :maintenance_fee_cents,
      :sun_position,
      :status,
      tag_ids: []
    )
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def select_tags
    @tags = Tag.where(plugin: 'property')
  end
end
