class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  layout :set_layout

  protected
  def check_if_is_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to :action => :show, :id => @user.login
      return
    end
  end

  def set_layout
    return 'application' unless params["xhr"]
  end

end