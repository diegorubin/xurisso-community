class Photo < ApplicationRecord

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :album

  has_many :comments, :as => 'commentable'
  has_many :approved_comments, -> {where(approved: true)},
    :as => 'commentable', :class_name => 'Comment'

  validates :title, presence: true
  validates :image, presence: true

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
