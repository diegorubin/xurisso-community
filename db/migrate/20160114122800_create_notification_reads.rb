class CreateNotificationReads < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_reads do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :notification, index: true, foreign_key: true

      t.timestamps
    end
  end
end
