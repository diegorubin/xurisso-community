class AddUserCanParticipateToEvent < ActiveRecord::Migration
  def up
    add_column :events, :user_can_participate, :boolean, :default => true
  end
  def down
    remove_column :events, :user_can_participate
  end
end
