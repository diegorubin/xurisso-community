require 'rails_helper'

describe SurveyAnswersController, type: :controller do
  login_user

  # CREATE 
  context "on create survey answer" do

    before(:each) do
      survey = FactoryGirl(:survey)
      @survey_answer_attr = FactoryGirl.attributes_for(:survey_answer, :survey_id => survey.id, :survey_option_id => FactoryGirl(:survey_option, :survey => survey).id)
    end

    it "dont save survey answer" do
      @survey_answer_attr[:survey_option_id] = ''

      lambda do
        post :create, :survey_answer => @survey_answer_attr
      end.should change(SurveyAnswer, :count).by(0)
    end

    it "save survey answer" do

      lambda do
        post :create, :survey_answer => @survey_answer_attr 
      end.should change(SurveyAnswer, :count).by(1)
    end

  end

end

