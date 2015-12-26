class SurveyOption < ApplicationRecord
  belongs_to :survey
  has_many :survey_answers

  # Scopes
  scope :answer_of_user_for_survey, lambda { |user_id, survey_id|
    {
      :conditions => {
        'survey_answers.user_id' => user_id,
        'survey_answers.survey_id' => survey_id
      },
      :include => "survey_answers"
    }
  }

end
