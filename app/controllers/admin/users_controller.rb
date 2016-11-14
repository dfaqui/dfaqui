class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(allowed_params)

    if @user.save
      flash[:notice] = 'Usuário cadastrado com sucesso'
      redirect_to admin_users_path
    else
      flash[:error] = 'Erro ao cadastrar usuário'
      render :new
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(allowed_params)
      flash[:notice] = 'Usuário editado com sucesso'
      redirect_to admin_users_path
    else
      flash[:error] = 'Erro ao editar usuário'
      render :edit
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)

    if @user.update(allowed_params)
      flash[:notice] = 'Senha alterada com sucesso'

      bypass_sign_in(@user)
      redirect_to admin_path
    else
      flash[:error] = 'Erro ao alterar senha'
      render :edit_password
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'Usuário removido com sucesso'
    redirect_to admin_users_path
  end

  private

  def allowed_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
