class AddActiveToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :active, :boolean, :default => false
  end
end
