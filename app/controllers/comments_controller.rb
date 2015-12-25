class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    if @comment.save
      if params[:xhr]
        render :json => @comment
      else
        flash[:notice] = "Comentário enviado com sucesso."
        redirect_to :controller => :users, :action => :show, :id => @user.login
      end
    else
      if params[:xhr]
        render :json => @comment.errors, :status => 500
      else
        flash[:notice] = "Não foi possível enviar o comentário."
        render :action => :new
      end
    end
  end

  def update
  end

  def destroy
  end

end

