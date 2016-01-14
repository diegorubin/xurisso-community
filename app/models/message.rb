class Message < ApplicationRecord
  # relations
  belongs_to :from, :class_name => "User"
  belongs_to :to, :class_name => "User"

  # validates
  validates_presence_of :about, :body, :from, :to

  # callbacks
  after_create :notify

  scope :for_user, -> (user) {
    where(["removed_by_to = ? and to_id = ?", false, user.id])
  }

  # pagination
  paginates_per 10

  def notify
    message = I18n.t('notifications.messages.new_message')%(to.identifier)
    Notify.new(from,to).notify!(message)
  end

end

