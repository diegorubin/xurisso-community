class MessagesController < ApplicationController
  before_filter :get_user, :except => [:index, :show]

  def index
    @messages = Message.for_user(current_user).
                        order("updated_at DESC").
                        page(params[:page])
  end

  def new
    @message = Message.new
    @message.to = @user
    @message.from = current_user
    @message.about = params[:resp] if params[:resp]
  end

  def create
    @message = Message.new(params[:message])
    @message.to = @user
    @message.from = current_user

    if @message.save
      if params[:xhr]
        render :json => @message
      else
        flash[:notice] = "Mensagem enviada com sucesso."
        redirect_to :controller => :users, :action => :show, :id => @user.login
      end
    else
      if params[:xhr]
        render :json => @message.errors, :status => 500
      else
        flash[:notice] = "Não foi possível enviar a mensagem."
        render :action => :new
      end
    end
  end

  def show
    @message = current_user.received_messages.find(params[:id])
    @user = @message.from
  end

  def destroy
    @message = current_user.received_messages.find(params[:id])
    @message.removed_by_to = true
    if @message.save
      if params[:xhr]
        @messages = Message.for_user(current_user).
                            order("updated_at DESC").
                            page(params[:page])
        render :action => :index
      else
        flash[:notice] = "Mensagem removida com sucesso."
        redirect_to :controller => :messages, :action => :index, :user_id  => @user.login
      end
    else
      if params[:xhr]
        render :json => @message.errors, :status => 500
      else
        flash[:notice] = "Não foi possível remover a mensagem."
        redirect_to :controller => :messages, :action => :index, :user_id  => @user.login
      end
    end

  end

  private
  def get_user
    @user = User.find_by_login_or_id(params[:user_id], params[:user_id]).first
  end
end
