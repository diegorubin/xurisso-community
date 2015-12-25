class Book < ActiveRecord::Base
  belongs_to :testament
  has_many :chapters

  scope :testament, lambda { |value|
    {
      :conditions => {:testament_id => value}
    }
  }

end
