class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :from_id
      t.string :from_type
      t.integer :to_id
      t.string :to_type
      t.text :description

      t.timestamps
    end
  end
end
