class Admin::PropertyImagesController < Admin::BaseController
  before_action :set_property, only: [:edit, :update, :destroy]

  def index
    @images = PropertyImage.where(property: params[:property_id])
  end

  def show
  end

  def new
    @image = PropertyImage.new
  end

  def edit
  end

  def create
    @image = PropertyImage.new(allowed_params)
    @image.property_id = params[:property_id]

    if @image.save
      flash[:notice] = 'Imagem cadastrada com sucesso'
      redirect_to admin_property_property_images_path
    else
      flash[:error] = 'Erro ao cadastrar a imagem'
      render :new
    end
  end

  def update
    if @image.update(allowed_params)
      flash[:notice] = 'Imagem alterada com sucesso'
      redirect_to admin_property_property_images_path(@image.property_id)
    else
      flash[:error] = 'Erro ao alterar a imagem'
      render :edit
    end
  end

  def destroy
    @image.destroy
    flash[:notice] = 'Imagem removida com sucesso'
    redirect_to admin_property_property_images_path(@image.property_id)
  end

  private
  def allowed_params
    params.require(:property_image).permit(
      :image,
      :name,
      :order,
      :status
    )
  end

  def set_property
    @image = PropertyImage.find(params[:id])
  end
end
