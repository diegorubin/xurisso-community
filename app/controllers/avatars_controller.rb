class AvatarsController < ApplicationController
  before_filter :check_if_is_user, :only => [:edit, :update]

  def create
    @user = current_user
    File.open(upload_path, 'w') do |f|
      f.write request.raw_post
    end
    @user.avatar = File.open(upload_path)
    @user.save

    render :text => "ok"
  end

  def show
    redirect_to :action => :edit, :id => params[:id]
  end

  def edit
  end

  def update
    if params[:user] && params[:user][:avatar]
      @user.avatar = params[:user][:avatar]
      if @user.save

        if params[:xhr]
          render :json => @user.avatar.example.url
        else
          flash[:notice] = "Foto salva com sucesso."
          redirect_to :action => :edit, :id => params[:id]
        end

      else

        if params[:xhr]
          render :json => @user.errors, :status => 500
        else
          flash[:alert] = "Não foi possível salvar a imagem."
          redirect_to :action => :edit, :id => params[:id]
        end

      end
    else

      if params[:xhr]
        render :json => @user.errors, :status => 500
      else
        flash[:alert] = "Nenhuma imagem foi enviada."
        redirect_to :action => :edit, :id => params[:id]
      end

    end
  end

  private

  def upload_path # is used in upload and create
    file_name = session[:session_id].to_s + '.jpg'
    File.join(Rails.root, 'tmp', 'uploads', file_name)
  end

end
