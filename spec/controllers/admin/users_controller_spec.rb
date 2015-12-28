require 'rails_helper'

describe Admin::UsersController, type: :controller do
  login_admin

  let(:user) do 
    user = create(:user)
    user.skip_confirmation!
    user
  end
  
  it "should redirect to home if user not is admin" do
    sign_in user

    get :index
    expect(response).to be_redirect
  end

  # INDEX
  it "GET /index" do
    get :index
    expect(response).to be_success
  end

  # NEW
  it "GET /new" do
    get :new
    expect(response).to be_success
  end

  # CREATE 
  context "on create user" do

    let(:user_attributes) {attributes_for(:user, login: '')}

    it "dont save user" do
      expect {
        post :create, :user => user_attributes
        expect(response).to be_success
      }.to change(User, :count).by(0)
    end

    it "save user type" do
      user_attributes[:login] = "teste#{rand(999)}"

      expect {
        post :create, :user => user_attributes
        expect(response).to be_redirect
      }.to change(User, :count).by(1)
    end

  end

  # EDIT 
  it "GET /edit" do
    get :edit, :id => user.id
    expect(response).to be_success
  end

  # UPDATE 
  context "on update user" do

    it "dont save user" do
      user.login = ""
      patch :update, :id => user.id, :user => user.attributes
      expect(response).to be_success
    end

    it "save user" do
      user.login = "nome#{rand(999)}"
      patch :update, :id => user.id, :user => user.attributes 
      expect(response).to be_redirect
    end

  end

  # DELETE
  it "DELETE /destroy" do
    delete :destroy, :id => user.id
    response.should be_redirect
    User.where(:id => user.id).first.should be_nil
  end
  

end

