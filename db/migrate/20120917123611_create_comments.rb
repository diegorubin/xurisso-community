class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.boolean :removed
      t.boolean :approved
      t.belongs_to :user
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
    add_index :comments, :user_id
  end
end
