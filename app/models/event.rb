class Event < ApplicationRecord
  attr_accessor :current_user_participating

  belongs_to :user
  belongs_to :category, :class_name => "EventCategory",
                        :foreign_key => "event_category_id"

  has_and_belongs_to_many :users

  validates_presence_of :title

  scope :after, -> (date) {
    where(["start_at >= ?", date])
  }

  def as_json(*args)
    hash = super(*args)
    hash.merge!(
      {
        :current_user_participating => current_user_participating,
        :user_thumbs => user_thumbs
      }
    )
  end

  private
  def user_thumbs
    users.collect{|u| [u.login, u.avatar.microthumb.url]}
  end
  
end
