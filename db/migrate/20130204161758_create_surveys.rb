class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
