class EventCategory < ApplicationRecord
  
  validates :title, presence: true
  validates :icon_name, presence: true

end

