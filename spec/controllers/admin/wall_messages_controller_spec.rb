require 'rails_helper'

describe Admin::WallMessagesController, type: :controller do
  login_admin
  
  # INDEX
  it "GET /index" do
    get :index
    response.should be_success
  end

  # UPDATE
  context "on update wall message" do
    it "should block a wall message" do
      @wall_message = FactoryGirl(:wall_message, :user => FactoryGirl(:user))
      lambda do
        put :update, :id => @wall_message.id, :wall_message => {:blocked => true}
        response.should be_redirect
      end.should change(WallMessage, :count).by(0)

      WallMessage.find(@wall_message.id).should be_blocked
    end

    it "should remove a wall message" do
      @wall_message = FactoryGirl(:wall_message, :user => FactoryGirl(:user))
      lambda do
        put :update, :id => @wall_message.id, :wall_message => {:removed => true}
        response.should be_redirect
      end.should change(WallMessage, :count).by(-1)

      WallMessage.first(:conditions => {:id => @wall_message.id}).should be_nil
    end

  end

end

