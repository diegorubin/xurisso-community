class CreateVersicles < ActiveRecord::Migration
  def self.up
    create_table :versicles do |t|
      t.belongs_to :chapter
      t.text :text
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :versicles
  end
end
