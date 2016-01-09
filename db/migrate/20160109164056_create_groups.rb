class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.boolean :only_by_invite
      t.integer :owner_id
      t.boolean :is_private
      t.string :cover

      t.timestamps
    end
  end
end
