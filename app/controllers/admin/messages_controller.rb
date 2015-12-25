class Admin::MessagesController < AdminController
  def index
    @messages = Message.order("created_at DESC").page(params.fetch(:page,1))
  end

end
