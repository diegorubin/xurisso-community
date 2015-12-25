class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :versicles

  scope :book_abbreviation, lambda { |value|
    {
      :conditions => {:books => {:abbreviation => value}},
      :include => [:book]
    }
  }

  scope :number, lambda { |value|
    {
      :conditions => {:number => value}
    }
  }

end
