class WallMessagesController < ApplicationController

  def index
    @wall_messages = WallMessage.list(params.fetch(:offset,0), 10)
  end

  def new
    @wall_message = WallMessage.new
  end

  def create 
    @wall_message = WallMessage.new(wall_message_params)
    @wall_message.user = current_user
    if @wall_message.save
      render :partial => 'wall_message', 
             :locals => {:wall_message => @wall_message}, 
             :layout => false
    else
      render :json => {:status => 'error', :errors => @wall_message.errors}
    end
  end

  private
  def wall_message_params
    params.require(:wall_message).permit(:description)
  end

end

