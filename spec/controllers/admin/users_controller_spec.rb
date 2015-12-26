require 'rails_helper'

describe Admin::UsersController, type: :controller do
  login_admin

  let(:user) {FactoryGirl.create(:user).skip_confirmation!}
  
  it "should redirect to home if user not is admin" do
    sign_in user

    get :index
    response.should be_redirect
  end

  # INDEX
  it "GET /index" do
    get :index
    response.should be_success
  end

  # NEW
  it "GET /new" do
    get :new
    response.should be_success
  end

  # CREATE 
  context "on create user" do

    before(:each) do
      @user_attr = FactoryGirl.attributes_for(:user)
      @user_attr[:login] = ""
    end

    it "dont save user" do
      lambda do
        post :create, :user => @user_attr
        response.should be_success
      end.should change(User, :count).by(0)
    end

    it "save user type" do
      @user_attr[:login] = "teste#{rand(999)}"

      lambda do
        post :create, :user => @user_attr 
        response.should be_redirect
      end.should change(User, :count).by(1)
    end

  end

  # EDIT 
  it "GET /edit" do
    get :edit, :id => @user.id
    response.should be_success
  end

  # UPDATE 
  context "on update user" do

    before(:each) do
      @user = FactoryGirl(:user)
    end

    it "dont save user" do
      @user.login = ""
      put :update, :id => @user.id, :user => @user.attributes
      response.should be_success
    end

    it "save user" do
      @user.login = "nome#{rand(999)}"

      put :update, :id => @user.id, :user => @user.attributes 
      response.should be_redirect
    end

  end

  # DELETE
  it "DELETE /destroy" do
    user = FactoryGirl(:user)

    delete :destroy, :id => user.id
    response.should be_redirect

    User.where(:id => user.id).first.should be_nil
  end
  

end

