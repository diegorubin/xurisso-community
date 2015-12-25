class WallMessagesController < ApplicationController

  def index
    @wall_messages = WallMessage.not_blocked.
                                 offset(params.fetch(:offset,0).to_i).
                                 limit(10)
  end

  def new
    @wall_message = WallMessage.new
  end

  def create 
    @wall_message = WallMessage.new(params[:wall_message])
    @wall_message.user = current_user
    if @wall_message.save
      render :partial => 'wall_message', 
             :locals => {:wall_message => @wall_message}, 
             :layout => false
    else
      render :json => {:status => 'error', :errors => @wall_message.errors}
    end
  end

end

