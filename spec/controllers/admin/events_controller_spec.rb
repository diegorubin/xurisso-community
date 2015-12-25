require 'spec_helper'

describe Admin::EventsController do
  before(:each) do
    @user = User.new(Factory.attributes_for(:user))
    @user.admin = true
    @user.skip_confirmation!
    @user.save
    sign_in @user

    @event = Factory(:event, 
                     :category => Factory(:event_category),
                     :user => Factory(:user))
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
  context "on create event" do

    before(:each) do
      @event_attr = Factory.attributes_for(:event)
      @event_attr[:title] = ""
    end

    it "dont save event" do
      lambda do
        post :create, :event => @event_attr
        response.should be_success
      end.should change(Event, :count).by(0)
    end

    it "save event type" do
      @event_attr[:title] = "teste do controller"
      @event_attr[:event_category_id] = Factory(:event_category).id

      lambda do
        post :create, :event => @event_attr 
        response.should be_redirect
      end.should change(Event, :count).by(1)
    end

  end

  # EDIT 
  it "GET /edit" do
    get :edit, :id => @event.id
    response.should be_success
  end

  # UPDATE 
  context "on update event" do

    before(:each) do
      @event = Factory(:event, 
                       :category => Factory(:event_category),
                       :user => Factory(:user))
    end

    it "dont save event" do
      @event.title = ""
      put :update, :id => @event.id, :event => @event.attributes
      response.should be_success
    end

    it "save event" do
      @event.title = "Novo nome"

      put :update, :id => @event.id, :event => @event.attributes 
      response.should be_redirect
    end

  end

  # DELETE
  it "DELETE /destroy" do
    event = Factory(:event, 
                    :category => Factory(:event_category),
                    :user => Factory(:user))

    delete :destroy, :id => event.id
    response.should be_redirect

    Event.where(:id => event.id).first.should be_nil
  end
  
end

