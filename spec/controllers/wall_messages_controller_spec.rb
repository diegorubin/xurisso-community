require 'spec_helper'

describe WallMessagesController do
  before(:each) do
    @user = User.new(Factory.attributes_for(:user))
    @user.admin = true
    @user.skip_confirmation!
    @user.save
    sign_in @user
  end

  # INDEX
  context "on list of wall messages" do
    it "should get list from wall messages" do
      get :index
      response.should be_success
    end
  end

  # NEW
  it "should get form of a new message" do
    get :new
    response.should be_success
  end

  # CREATE 
  context "on create wall message" do

    before(:each) do
      @wall_message_attr = Factory.attributes_for(:wall_message)
    end

    it "dont save wall message" do
      @wall_message_attr[:description] = ''

      lambda do
        post :create, :wall_message => @wall_message_attr
      end.should change(WallMessage, :count).by(0)
    end

    it "save wall message" do

      lambda do
        post :create, :wall_message => @wall_message_attr 
      end.should change(WallMessage, :count).by(1)
    end

  end

end

