class Group < ApplicationRecord

  has_many :participations

  scope :for_user, -> (user) {
    includes(:participations)
      .where(['participations.user_id = ? OR is_private = ?', user.id, false])
      .references(:participations)
  }

end
