class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.belongs_to :user
      t.belongs_to :album

      t.timestamps
    end
    add_index :albums, :user_id
    add_index :albums, :album_id
  end
end
