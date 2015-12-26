module ControllerMacros

  def login_admin
    simple_login(:admin)
  end

  def login_user
    simple_login(:user)
  end

  private 
  def simple_login(resource = :user)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(resource)
      user.confirm!
      sign_in user
    end
  end

end

