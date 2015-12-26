class Message < ApplicationRecord
  # relations
  belongs_to :from, :class_name => "User"
  belongs_to :to, :class_name => "User"

  # validates
  validates_presence_of :about, :body, :from, :to

  scope :for_user, lambda {|user|
    {:conditions => ["removed_by_to = ? and to_id = ?", false, user.id]}
  }

  # pagination
  paginates_per 10

end
