class AddBirthdayToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :can_display_birthday, :boolean
  end

  def self.down
    remove_column :users, :can_display_birthday
  end
end
