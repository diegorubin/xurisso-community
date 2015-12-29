class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, :only => [:create]

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u| 
        u.permit(:login, :email, :password, :password_confirmation) 
      end
    end
end

