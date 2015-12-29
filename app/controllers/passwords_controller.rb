class PasswordsController < ApplicationController

  before_action :check_if_is_user, :only => [:edit, :update]

  def edit
  end

  def update
    if @user.update(user_params)

      if params[:xhr]
        render :json => @user
      else
        flash[:notice] = "Informações atualizadas com sucesso."
        redirect_to :controller => :users, :action => :show, :id => @user.login
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

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end

