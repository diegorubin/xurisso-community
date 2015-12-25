require 'spec_helper'

describe SurveyAnswersController do
  before(:each) do
    @user = User.new(Factory.attributes_for(:user))
    @user.admin = true
    @user.skip_confirmation!
    @user.save
    sign_in @user
  end

  # CREATE 
  context "on create survey answer" do

    before(:each) do
      survey = Factory(:survey)
      @survey_answer_attr = Factory.attributes_for(:survey_answer, :survey_id => survey.id, :survey_option_id => Factory(:survey_option, :survey => survey).id)
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

