class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :about
      t.text :body
      t.belongs_to :from
      t.belongs_to :to

      t.timestamps
    end
    add_index :messages, :from_id
    add_index :messages, :to_id
  end
end
