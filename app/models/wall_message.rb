class WallMessage < ApplicationRecord

  validates :description, presence: true
  validates :user, presence: true

  belongs_to :user

  default_scope -> {
    where(:removed => false)
      .where('users.removed' => false, 'users.blocked' => false)
      .includes(:user)
      .order('wall_messages.created_at DESC')
  }

  scope :not_blocked, -> { where(blocked: false) }
  scope :list, -> (offset, limit) {
    not_blocked.offset(offset).limit(limit)
  }

end

