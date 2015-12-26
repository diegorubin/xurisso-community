require 'rails_helper'

describe Admin::MessagesController, type: :controller do
  login_admin
  
  # INDEX
  it "GET /index" do
    get :index
    expect(response).to be_success
  end

end

