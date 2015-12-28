require 'rails_helper'

describe Survey do

  let(:survey) { create(:survey) }
  let!(:options) {
    options = []
    4.times do |i|
      options << create(:survey_option, :survey => survey, 
        :description => "opcao #{i}")
    end
    options
  }

  let!(:survey_answer) {
    create(:survey_answer, :survey_option => options[1],
      :survey => survey, :user => user)
  }

  let(:another_survey_answer) {
    create(:survey_answer, :survey_option => options[1],
      :survey => survey, :user => another_user)
  }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  let(:answers) do
    create(:survey_answer, :survey_option => options[1],
      :survey => survey, :user => create(:user))

    create(:survey_answer, :survey_option => options[1],
      :survey => survey, :user => create(:user))

    create(:survey_answer, :survey_option => options[0],
      :survey => survey, :user => create(:user))
  end

  it "should calculate percentages" do
    result = survey.result  
    expect(result).to eql({
      options[1] => 100
    })

    answers

    survey.reload
    result = survey.result  
    expect(result).to eql({
      options[1] => 75,
      options[0] => 25
    })
  end

  it "should create only one answer per user" do
    expect(survey.can_answer?(another_user)).to be_truthy
    another_survey_answer
    expect(survey.can_answer?(another_user)).to be_falsey
  end

  context "on recover" do
    let(:survey) { create(:survey, :active => true) }

    it "should get only active surveys" do
      Survey.actives.count.should == 1
    end

  end

end

