class Admin::Markets::ProductsController < Admin::BaseController
  before_action :set_market, only: [:index, :new, :create, :edit]
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = @market.products
  end

  def show
  end

  def new
    @product = @market.products.build
  end

  def edit
  end

  def create
    product_params = allowed_params

    if product_params[:price_cents].present?
      product_params[:price_cents]  = product_params[:price_cents].
                                      gsub('.', '').
                                      gsub(',', '.')
    end

    @product = @market.products.new(product_params)

    if @product.save
      flash[:notice] = 'Produto cadastrado com sucesso'
      redirect_to admin_market_products_path(@market.id)
    else
      flash[:error] = 'Erro ao cadastrar produto'
      render :new
    end
  end

  def update
    if @product.update(allowed_params)
      flash[:notice] = 'Produto editado com sucesso'
      redirect_to admin_market_products_path(@product.market_id)
    else
      flash[:error] = 'Erro ao editar produto'
      render :edit
    end
  end

  def destroy
    @product.destroy

    flash[:notice] = 'Produto removido com sucesso'
    redirect_to admin_market_products_path(@product.market_id)
  end

  private

  def allowed_params
    params.require(:product).permit(
      :name,
      :description,
      :photo,
      :price_cents,
      :status
    )
  end

  def set_market
    @market = Market.find(params[:market_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
