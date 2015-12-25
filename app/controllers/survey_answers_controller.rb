class SurveyAnswersController < ApplicationController

  def create 
    @survey_answer = SurveyAnswer.new(params[:survey_answer])
    @survey_answer.user = current_user
    if @survey_answer.save
      render
    else
      render :json => {:status => 'error', :errors => @survey_answer.errors}
    end
  end
 
end
