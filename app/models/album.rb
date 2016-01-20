class Album < ApplicationRecord
  belongs_to :user
  belongs_to :album, optional: true

  has_many :photos

  validates :title, presence: true

  paginates_per 9

  def cover
    if photos.count > 0
      photos.first.thumb.url
    else
      "/assets/fallback/thumb_image.png"
    end
  end

  def as_json(*args)
    hash = super(*args)
    hash.merge!(
      {
        :cover => cover
      }
    )
  end
end

