class Admin::UsersController < AdminController
  before_action :get_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params.fetch(:page,1))
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Usuário criado com sucesso."
      redirect_to :action => :index
    else
      flash[:alert] = "Não foi possível criar o usuário."
      render :action => :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Usuário atualizado com sucesso."
      redirect_to :action => :index
    else
      flash[:alert] = "Não foi possível atualizar o usuário."
      render :action => :edit
    end
  end

  def destroy

    if current_user.id != @user.id && @user.remove
      flash[:notice] = "Usuário removido com sucesso."
    else
      flash[:alert] = "Não foi possível remover o usuário."
    end

    redirect_to :action => :index
  end

  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
      .permit(:name, :login, :email, :password, :password_confirmation,
        :admin, :blocked)
  end

end

