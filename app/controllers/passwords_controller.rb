class PasswordsController < ApplicationController
  include FormResponse

  before_action :check_if_is_user, :only => [:edit, :update]

  def edit
  end

  protected
  def resource_name
    'user'
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end

