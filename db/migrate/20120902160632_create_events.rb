class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :published
      t.belongs_to :user

      t.timestamps
    end
    add_index :events, :user_id
  end
end
