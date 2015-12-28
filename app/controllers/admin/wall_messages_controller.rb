class Admin::WallMessagesController < AdminController

  def index
    @wall_messages = WallMessage.page(params.fetch(:page,1))
  end

  def update

    @wall_message = WallMessage.find(params[:id])
    if @wall_message.update(wall_message_params)
      flash[:notice] = "Mensagem atualizada com sucesso."
    else
      flash[:alert] = "Não foi possível atualizar a mensagem."
    end

    redirect_to :action => :index
  end

  def wall_message_params
    params.require(:wall_message)
      .permit(:description, :user_id, :blocked, :removed)
  end

end

