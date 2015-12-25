class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :abbreviation
      t.string :slug
      t.belongs_to :testament

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
