class AddSurveyOptionToSurveyAnswer < ActiveRecord::Migration
  def change
    add_column :survey_answers, :survey_option_id, :integer
  end
end
