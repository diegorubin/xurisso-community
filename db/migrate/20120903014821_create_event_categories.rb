class CreateEventCategories < ActiveRecord::Migration
  def change
    create_table :event_categories do |t|
      t.string :title
      t.string :icon_name

      t.timestamps
    end
  end
end
