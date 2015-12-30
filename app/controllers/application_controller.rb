class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
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
    if params.fetch('xhr', false)
      false
    else
      params['controller'] =~ /(devise|registration)/ ? 'login' : 'application'
    end
  end

  def resource_class
    controller_name.classify.constantize
  end

  def set_object_variable(value)
    instance_variable_set("@#{resource_name}", value)
  end

  def get_object_variable
    instance_variable_get("@#{resource_name}")
  end

  def resource_name
    controller_name.singularize
  end

end

