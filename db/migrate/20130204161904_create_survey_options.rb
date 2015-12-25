class CreateSurveyOptions < ActiveRecord::Migration
  def change
    create_table :survey_options do |t|
      t.text :description
      t.belongs_to :survey

      t.timestamps
    end
    add_index :survey_options, :survey_id
  end
end
