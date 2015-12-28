require 'rails_helper'

describe Admin::WallMessagesController, type: :controller do
  login_admin
  
  # INDEX
  it "GET /index" do
    get :index
    expect(response).to be_success
  end

  # UPDATE
  context "on update wall message" do

    let(:wall_message) { create(:wall_message, :user => create(:user)) }

    before(:each) { wall_message }

    it "should block a wall message" do
      expect {
        patch :update, :id => wall_message.id, 
          :wall_message => {:blocked => true}
        expect(response).to be_redirect
      }.to change(WallMessage, :count).by(0)

      expect(WallMessage.find(wall_message.id)).to be_blocked
    end

    it "should remove a wall message" do
      expect {
        patch :update, :id => wall_message.id, 
          :wall_message => {:removed => true}
        response.should be_redirect
      }.to change(WallMessage, :count).by(-1)

      expect(WallMessage.where(id: wall_message.id).first).to be_nil
    end

  end

end

