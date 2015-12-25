class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey
  belongs_to :survey_option
  belongs_to :user

  validates_presence_of :survey_id, :survey_option_id, :user_id

end
