class SurveyOption < ApplicationRecord
  belongs_to :survey
  has_many :survey_answers

  # Scopes
  scope :answer_of_user_for_survey, -> (user_id, survey_id) {
    where('survey_answers.user_id' => user_id)
      .where('survey_answers.survey_id' => survey_id)
      .includes('survey_answers')
  }

end
