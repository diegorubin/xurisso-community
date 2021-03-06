class AdminController < ApplicationController
  before_action :is_admin?

  protected
  def set_layout
    'admin'
  end

  def is_admin?
    unless current_user.admin?
      redirect_to root_url
      return
    end
  end

end
