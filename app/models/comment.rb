class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates_presence_of :body, :user_id, :commentable_id, :commentable_type

  scope :approveds, lambda {
    {:conditions => ['approved = ?', true]}
  }

end
