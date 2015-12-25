require 'spec_helper'

describe Admin::SurveysController do
  before(:each) do
    @user = User.new(Factory.attributes_for(:user))
    @user.admin = true
    @user.skip_confirmation!
    @user.save
    sign_in @user

    @survey = Factory(:survey)

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
  context "on create survey" do

    before(:each) do
      @survey_attr = Factory.attributes_for(:survey)
      @survey_attr[:title] = ""
    end

    it "dont save survey" do
      lambda do
        post :create, :survey => @survey_attr
        response.should be_success
      end.should change(Survey, :count).by(0)
    end

    it "save survey type" do
      @survey_attr[:title] = "teste do controller"

      lambda do
        post :create, :survey => @survey_attr 
        response.should be_redirect
      end.should change(Survey, :count).by(1)
    end

  end

  # SHOW 
  it "GET /:id" do
    get :show, :id => @survey.id
    response.should be_success
  end

  # EDIT 
  it "GET /edit" do
    get :edit, :id => @survey.id
    response.should be_success
  end

  # UPDATE
  context "on update survey" do
    it "should block a wall message" do
      @survey = Factory(:survey)
      lambda do
        put :update, :id => @survey.id, :survey => {:active => true}
        response.should be_redirect
      end.should change(Survey, :count).by(0)

      @survey.reload
      @survey.should be_active
    end

  end

  # DELETE
  it "DELETE /destroy" do
    survey = Factory(:survey)

    delete :destroy, :id => survey.id
    response.should be_redirect

    Survey.where(:id => survey.id).first.should be_nil
  end

end

