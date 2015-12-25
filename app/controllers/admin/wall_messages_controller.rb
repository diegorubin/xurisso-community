class Admin::WallMessagesController < AdminController

  def index
    @wall_messages = WallMessage.page(params.fetch(:page,1))
  end

  def update

    @wall_message = WallMessage.find(params[:id])
    if @wall_message.update_attributes(params[:wall_message])
      flash[:notice] = "Mensagem atualizada com sucesso."
    else
      flash[:alert] = "Não foi possível atualizar a mensagem."
    end

    redirect_to :action => :index
  end
end
