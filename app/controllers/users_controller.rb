class UsersController < ApplicationController
  before_filter :get_user, :only => [:show]
  before_filter :check_if_is_user, :only => [:edit, :update]

  # Exibe todos os membros cadastrados
  def index 
    @users = User.except_user(current_user).
                  order("name ASC, login ASC")
  end

  # Exibe o perfil de um membro
  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])

      if params[:xhr]
        render :json => @user
      else
        flash[:notice] = "Informações atualizadas com sucesso."
        redirect_to :action => :show, :id => @user.login
      end

    else

      if params[:xhr]
        render :json => @user.errors, :status => 500
      else
        flash[:notice] = "Não foi possível atualizar os dados."
        render :action => :edit
      end

    end
  end

  # remove conta do usuario
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

end

