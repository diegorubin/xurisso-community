class WallMessage < ActiveRecord::Base
  validates_presence_of :description, :user_id

  belongs_to :user

  default_scope :conditions => {
                  :removed => false, 
                  'users.removed' => false,
                  'users.blocked' => false
                },
                :include => :user,
                :order => "wall_messages.created_at DESC"

  scope :not_blocked, lambda {
    {:conditions => {:blocked => false}}
  }
end
