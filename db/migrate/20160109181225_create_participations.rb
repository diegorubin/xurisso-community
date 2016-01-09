class CreateParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :participations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :group, index: true, foreign_key: true
      t.integer :invited_by

      t.timestamps
    end
  end
end
