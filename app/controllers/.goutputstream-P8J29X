class AdminController < ApplicationController
  before_filter :is_admin?

  protected
  def is_admin?
    unless current_user.admin?
      redirect_to root_url
      return
    end
  end
end
