class CreateSurveyAnswers < ActiveRecord::Migration
  def change
    create_table :survey_answers do |t|
      t.belongs_to :survey
      t.belongs_to :user

      t.timestamps
    end
    add_index :survey_answers, :survey_id
    add_index :survey_answers, :user_id
  end
end
