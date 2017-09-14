class Micropost < ActiveRecord::Base
  # relations
  belongs_to :user

  # scope
  # order is descending from newest to oldest
  default_scope -> { order('created_at DESC') }

  # validation that user_id must not be empty
  validates :user_id, presence: true

  # validation that content must not be empty and less than 140 characters
  validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
