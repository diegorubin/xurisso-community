class CreateWallMessages < ActiveRecord::Migration
  def change
    create_table :wall_messages do |t|
      t.text :description
      t.belongs_to :user
      t.boolean :blocked, :default => false
      t.boolean :removed, :default => false

      t.timestamps
    end
    add_index :wall_messages, :user_id
  end
end
