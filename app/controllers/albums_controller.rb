class AlbumsController < ApplicationController
  before_action :check_if_is_user, :only => [:edit, :update, :destroy]
  before_action :get_user, :only => [:index]
  before_action :get_album, :only => [:edit, :update, :show, :destroy]

  def index
    @albums = @user.albums.page(params.fetch(:page,1))

    if @user == current_user
      render :template => "albums/index-admin"
    else
      render :template => "albums/index"
    end
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    @album.user = current_user

    if @album.save
      if params[:xhr]
        render :json => {:album => @album, :path => user_album_photos_path(current_user.login, @album) }
      else
        flash[:notice] = "Álbum criado com sucesso."
        redirect_to :controller => :users, :action => :show, :id => current_user.login
      end
    else
      if params[:xhr]
        render :json => @album.errors, :status => 500
      else
        flash[:notice] = "Não foi possível criar o álbum."
        render :action => :new
      end
    end

  end

  def edit
  end

  def update
    if @album.update_attributes(params[:album])
      if params[:xhr]
        render :json => {:album => @album, :path => user_album_path(current_user.login, @album) }
      else
        flash[:notice] = "Álbum atualizado com sucesso."
        redirect_to :controller => :albums, :action => :show, :user_id => current_user.login, :id => @album.id
      end
    else
      if params[:xhr]
        render :json => @photo.errors, :status => 500
      else
        flash[:notice] = "Não foi possível atualizar o álbum."
        render :action => :new
      end
    end
  end

  def show
    respond_to do |format|
      format.html { 
        render :partial => "album", :locals => {:album => @album, 
                                                :user => @user}
      }
      format.json { render :json => @album }
    end
  end

  def destroy
    if @album.destroy  
      if params[:xhr]
        render :json => {:album => @album}
      else
        flash[:notice] = "Álbum removido com sucesso."
      end
    else
      if params[:xhr]
        render :json => @album.errors, :status => 500
      else
        flash[:notice] = "Não foi possível remover o álbum."
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
  def get_user
    @user = User.find_by_login(params[:user_id])
  end

  def get_album
    @user = User.find_by_login_or_id(params[:user_id], params[:user_id]).first
    @album = @user.albums.find(params[:id])
  end

end
