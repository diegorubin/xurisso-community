require 'spec_helper'

describe Survey do
  before(:each) do
    @survey = Factory(:survey)
    @options = []

    4.times do |i|
      @options << Factory(:survey_option, :survey => @survey, 
                                          :description => "opcao #{i}")
    end
  end

  it "should calculate percentages" do

    answer1 = Factory(:survey_answer, :survey_option => @options[1],
                                      :survey => @survey,
                                      :user => Factory(:user))

    result = @survey.result  
    result.should == {
      @options[1] => 100
    }

    answer2 = Factory(:survey_answer, :survey_option => @options[1],
                                      :survey => @survey,
                                      :user => Factory(:user))

    answer3 = Factory(:survey_answer, :survey_option => @options[1],
                                      :survey => @survey,
                                      :user => Factory(:user))

    answer4 = Factory(:survey_answer, :survey_option => @options[0],
                                      :survey => @survey,
                                      :user => Factory(:user))
    @survey.reload
    result = @survey.result  
    result.should == {
      @options[1] => 75,
      @options[0] => 25
    }

  end

  it "should create only one answer per user" do
    @user = Factory(:user)

    @survey.can_answer?(@user).should be_true
    answer = Factory(:survey_answer, :survey_option => @options[1],
                                     :survey => @survey,
                                     :user => @user)

    @survey.can_answer?(@user).should_not be_true
  end

  context "on recover" do
    it "should get only active surveys" do
      survey = Factory(:survey, :active => true)

      Survey.actives.count.should == 1
    end
  end
end
