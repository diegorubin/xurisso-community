require 'rails_helper'

describe SurveyAnswersController, type: :controller do
  login_user

  # CREATE 
  context "on create survey answer" do

    let(:survey) { FactoryGirl.create(:survey) }
    let(:survey_option) {FactoryGirl.create(:survey_option, :survey => survey)}
    let(:survey_answer_attributes) {
      FactoryGirl.attributes_for(:survey_answer, 
        :survey_id => survey.id, :survey_option_id => survey_option.id)
    }

    it "dont save survey answer" do
      survey_answer_attributes[:survey_option_id] = ''

      expect {
        post :create, :survey_answer => survey_answer_attributes
      }.to change(SurveyAnswer, :count).by(0)
    end

    it "save survey answer" do
      expect {
        post :create, :survey_answer => survey_answer_attributes
      }.to change(SurveyAnswer, :count).by(1)
    end

  end

end

