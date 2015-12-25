require 'spec_helper'

describe Admin::MessagesController do
  before(:each) do
    @user = User.new(Factory.attributes_for(:user))
    @user.admin = true
    @user.skip_confirmation!
    @user.save
    sign_in @user

  end
  
  # INDEX
  it "GET /index" do
    get :index
    response.should be_success
  end

end

