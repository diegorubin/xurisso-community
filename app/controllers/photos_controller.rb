class PhotosController < ApplicationController
  before_filter :check_if_is_user, :only => [:edit, :update, :destroy]
  before_filter :get_album
  before_filter :get_photo, :only => [:edit, :update, :destroy, :show]

  def index
    @photos = @album.photos.page(params.fetch(:page, 1))

    if @user == current_user
      render :template => "photos/index-admin"
    else
      render :template => "photos/index"
    end
  end  

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    @photo.user = current_user
    @photo.album = @album

    if @photo.save
      if params[:xhr]
        render :json => {:photo => @photo, :path => user_album_photo_path(current_user.login, @album, @photo) }
      else
        flash[:notice] = "Foto adicionada com sucesso."
        redirect_to :controller => :albums, :action => :show, :user_id => current_user.login, :id => @album.id
      end
    else
      if params[:xhr]
        render :json => @photo.errors, :status => 500
      else
        flash[:notice] = "Não foi possível adicionar a foto."
        render :action => :new
      end
    end
  end

  def edit
  end

  def update
    if @photo.update_attributes(params[:photo])
      if params[:xhr]
        render :json => {:photo => @photo, :path => user_album_photo_path(current_user.login, @album, @photo) }
      else
        flash[:notice] = "Foto atualizada com sucesso."
        redirect_to :controller => :albums, :action => :show, :user_id => current_user.login, :id => @album.id
      end
    else
      if params[:xhr]
        render :json => @photo.errors, :status => 500
      else
        flash[:notice] = "Não foi possível atualizar a foto."
        render :action => :new
      end
    end
  end

  def show
    respond_to do |format|
      format.html { 
        if params[:partial]
          render :partial => "photo", :locals => {:photo => @photo,
                                                :album => @album,
                                                :user => @user}
        else
          render :action => :show
        end
      }
      format.json {render :json => @photo}
    end
  end

  def destroy
    if @photo.destroy  
      if params[:xhr]
        render :json => {:photo => @photo}
      else
        flash[:notice] = "Foto removida com sucesso."
      end
    else
      if params[:xhr]
        render :json => @photo.errors, :status => 500
      else
        flash[:notice] = "Não foi possível remover a foto."
      end
    end

  end

  protected
  def check_if_is_user
    @user = User.find_by_login_or_id(params[:user_id], params[:user_id]).first
    unless current_user.id == @user.id
      redirect_to :action => :show, :id => @user.login
      return
    end
  end

  private
  def get_album
    @user = User.find_by_login_or_id(params[:user_id], params[:user_id]).first
    @album = @user.albums.find(params[:album_id])
  end

  def get_photo
    @photo = @album.photos.find(params[:id])
  end
end
