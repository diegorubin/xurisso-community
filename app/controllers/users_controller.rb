class UsersController < ApplicationController
  before_action :get_user, :only => [:show]
  before_action :check_if_is_user, :only => [:edit, :update]

  def index 
    @users = User.except_user(current_user).
                  order("name ASC, login ASC")
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)

      if params[:xhr]
        render :json => @user
      else
        flash[:notice] = "Informações atualizadas com sucesso."
        redirect_to :action => :show, :id => @user.login
      end

    else

      if params[:xhr]
        render :json => @user.errors, :status => 422
      else
        flash[:notice] = "Não foi possível atualizar os dados."
        render :action => :edit
      end

    end
  end

  def destroy
    user = current_user
    user.removed = true
    if user.save
      if params[:xhr]
        render :json => user
      else
        flash[:notice] = "Sua conta foi removida com sucesso."
        redirect_to :controller => :users, :action => :index, :id  => user.login
      end
    else
      if params[:xhr]
        render :json => user.errors, :status => 500
      else
        flash[:notice] = "Não foi possível remover a mensagem."
        redirect_to :controller => :users, :action => :index, :id  => user.login
      end
    end
  end

  private
  def get_user
    @user = User.find_by_login(params[:id])
  end

  def user_params
    params.require(:user)
      .permit(:name, :email, :birthday_str, :can_display_birthday)
  end

end

