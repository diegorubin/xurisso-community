require 'spec_helper'

describe Survey do
  before(:each) do
    @survey = FactoryGirl(:survey)
    @options = []

    4.times do |i|
      @options << FactoryGirl(:survey_option, :survey => @survey, 
                                          :description => "opcao #{i}")
    end
  end

  it "should calculate percentages" do

    FactoryGirl(:survey_answer, :survey_option => @options[1],
                                      :survey => @survey,
                                      :user => FactoryGirl(:user))

    result = @survey.result  
    result.should == {
      @options[1] => 100
    }

    FactoryGirl(:survey_answer, :survey_option => @options[1],
                                      :survey => @survey,
                                      :user => FactoryGirl(:user))

    FactoryGirl(:survey_answer, :survey_option => @options[1],
                                      :survey => @survey,
                                      :user => FactoryGirl(:user))

    FactoryGirl(:survey_answer, :survey_option => @options[0],
                                      :survey => @survey,
                                      :user => FactoryGirl(:user))
    @survey.reload
    result = @survey.result  
    result.should == {
      @options[1] => 75,
      @options[0] => 25
    }

  end

  it "should create only one answer per user" do
    @user = FactoryGirl(:user)

    @survey.can_answer?(@user).should be_true
    FactoryGirl(:survey_answer, :survey_option => @options[1],
                                     :survey => @survey,
                                     :user => @user)

    @survey.can_answer?(@user).should_not be_true
  end

  context "on recover" do
    it "should get only active surveys" do
      FactoryGirl(:survey, :active => true)

      Survey.actives.count.should == 1
    end
  end
end
