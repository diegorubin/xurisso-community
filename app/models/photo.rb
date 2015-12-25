class Photo < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :album

  has_many :comments, :as => 'commentable'
  has_many :approved_comments, :as => 'commentable', 
                               :class_name => 'Comment',
                               :conditions => ['approved = ?', true]

  paginates_per 27

  def thumb
    image.thumb
  end

  def as_json(*args)
    hash = super(*args)
    hash.merge!(
      {
        :thumb => thumb.url 
      }
    )
  end

end
