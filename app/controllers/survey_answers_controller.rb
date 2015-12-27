class SurveyAnswersController < ApplicationController

  def create 
    @survey_answer = SurveyAnswer.new(survey_answer_params)
    @survey_answer.user = current_user
    if @survey_answer.save
      render
    else
      render :json => {:status => 'error', :errors => @survey_answer.errors}
    end
  end
  
  private
  def survey_answer_params
    params.require(:survey_answer)
      .permit(:survey_id, :user_id, :survey_option_id)
  end

end

