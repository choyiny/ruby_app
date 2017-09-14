class Relationship < ActiveRecord::Base
  # relationships
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"


  # validations
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
