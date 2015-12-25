class AddRemovedToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :removed_by_from, :boolean, :default => false
    add_column :messages, :removed_by_to, :boolean, :default => false
  end

  def self.down
    remove_column :messages, :removed_by_from
    remove_column :messages, :removed_by_to
  end
end
