class CreateChapters < ActiveRecord::Migration
  def self.up
    create_table :chapters do |t|
      t.belongs_to :book
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :chapters
  end
end
