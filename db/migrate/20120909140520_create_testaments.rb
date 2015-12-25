class CreateTestaments < ActiveRecord::Migration
  def self.up
    create_table :testaments do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :testaments
  end
end
