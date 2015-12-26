require 'rails_helper'

describe WallMessagesController, type: :controller do
  login_user

  # INDEX
  context "on list of wall messages" do
    it "should get list from wall messages" do
      get :index
      expect(response).to be_success
    end
  end

  # NEW
  it "should get form of a new message" do
    get :new
    expect(response).to be_success
  end

  # CREATE 
  context "on create wall message" do

    let(:wall_message_attributes) do
      FactoryGirl.attributes_for(:wall_message)
    end

    it "not save wall message" do
      wall_message_attributes[:description] = ''

      expect{
        post :create, :wall_message => wall_message_attributes
      }.to change(WallMessage, :count).by(0)
    end

    it "save wall message" do
      expect {
        post :create, :wall_message => wall_message_attributes
      }.to change(WallMessage, :count).by(1)
    end

  end

end

