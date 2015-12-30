class UsersController < ApplicationController
  include FormResponse

  before_action :get_user, only: [:show]
  before_action :get_current_user, only: [:edit, :update]

  def index 
    @users = User.except_user(current_user).
                  order("name ASC, login ASC")
  end

  def show
  end

  def edit
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

  def get_current_user
    @user = current_user
  end

  def user_params
    params.require(:user)
      .permit(:name, :email, :birthday_str, :can_display_birthday)
  end

end

