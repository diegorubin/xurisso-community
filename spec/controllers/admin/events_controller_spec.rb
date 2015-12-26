require 'rails_helper'

describe Admin::EventsController, type: :controller do
  login_admin

  let(:user) { FactoryGirl(:user) }
  let(:category) { FactoryGirl(:event_category) }
  let(:event) { FactoryGirl(:event, category: category, user: user) }
  
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
  context "on create event" do

    let(:event_category) { FactoryGirl(:event_category) }
    let(:event_attributes) { FactoryGirl.attributes_for(:event, title: '') }

    it "dont save event" do
      expect {
        post :create, :event => event_attributes
        expect(response).to be_success
      }.to change(Event, :count).by(0)
    end

    it "save event type" do
      event_attributes[:title] = "teste do controller"
      event_attributes[:event_category_id] = event_category.id

      expect {
        post :create, :event => event_attributes
        response.should be_redirect
      }.to change(Event, :count).by(1)
    end

  end

  # EDIT 
  it "GET /edit" do
    get :edit, :id => @event.id
    expect(response).to be_success
  end

  # UPDATE 
  context "on update event" do

    it "dont save event" do
      event.title = ""
      patch :update, :id => event.id, :event => event.attributes
      expect(response).to be_success
    end

    it "save event" do
      event.title = "Novo nome"
      patch :update, :id => event.id, :event => event.attributes 
      expect(response).to be_redirect
    end

  end

  # DELETE
  it "DELETE /destroy" do
    delete :destroy, :id => event.id
    expect(response).to be_redirect

    expect(Event.where(:id => event.id).first).to be_nil
  end
  
end

