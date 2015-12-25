class PasswordsController < ApplicationController

  before_filter :check_if_is_user, :only => [:edit, :update]

  def edit
  end

  def update
    if @user.update_attributes(params[:user])

      if params[:xhr]
        render :json => @user
      else
        flash[:notice] = "Informações atualizadas com sucesso."
        redirect_to :controller => :users, :action => :show, :id => @user.login
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

end

