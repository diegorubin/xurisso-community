class Notification < ApplicationRecord

  belongs_to :from, polymorphic: true
  belongs_to :to, polymorphic: true

  scope :for_user, -> (user) {
    where({to: user})
      .order('created_at desc')
  }

end
