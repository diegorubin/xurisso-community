class EventCategory < ApplicationRecord
  
  validates :title, presence: true
  validates :icon_name, presence: true

  scope :admin_list, -> {
    order('title ASC')
  }

end

