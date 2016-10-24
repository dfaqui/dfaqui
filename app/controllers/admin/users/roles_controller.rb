class Admin::Users::RolesController < Admin::BaseController
  before_action :set_user, only: [:index, :new, :create, :destroy]

  def index
  end

  def new
  end

  def create
    role = allowed_params[:name]
    customer = Customer.find(allowed_params[:resource_id])

    @user.add_role role.to_sym, customer
    redirect_to admin_user_roles_path(@user.id)
  end

  def destroy
    @user.roles.find(params[:id]).destroy
    redirect_to admin_user_roles_path(@user.id)
  end

  private

  def allowed_params
    params.require(:role).permit(:name, :resource_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
