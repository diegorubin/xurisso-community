require 'rails_helper'

describe Admin::SurveysController, type: :controller do
  login_admin
  
  let(:survey) { FactoryGirl.create(:survey) }
  
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
  context "on create survey" do

    let(:survey_attributes) { FactoryGirl.attributes_for(:survey, title: '') }

    it "dont save survey" do
      expect {
        post :create, :survey => survey_attributes
        expect(response).to be_success
      }.to change(Survey, :count).by(0)
    end

    it "save survey type" do
      survey_attributes['title'] = "teste do controller"

      expect {
        post :create, :survey => survey_attributes
        expect(response).to be_redirect
      }.to change(Survey, :count).by(1)
    end

  end

  # SHOW 
  it "GET /:id" do
    get :show, id: survey.id
    expect(response).to be_success
  end

  # EDIT 
  it "GET /edit" do
    get :edit, id: survey.id
    expect(response).to be_success
  end

  # UPDATE
  context "on update survey" do
    it "should block the survey" do
      survey.update(active: false)
      expect {
        patch :update, :id => survey.id, :survey => {:active => true}
        response.should be_redirect
      }.to change(Survey, :count).by(0)

      survey.reload
      expect(survey).to be_active
    end

  end

  # DELETE
  it "DELETE /destroy" do
    delete :destroy, :id => survey.id
    response.should be_redirect

    expect(Survey.where(:id => survey.id).first).to be_nil
  end

end

