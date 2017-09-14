class User < ActiveRecord::Base

  # relations
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship"
  has_many :followers, through: :reverse_relationships

  # before saving the user object to the database, turn email to all lowercase
  before_save { self.email = email.downcase }

  # before creating, create a remember token
  before_create :create_remember_token


  # validation: name cannot be blank, and more than 50 characters
  validates(:name, presence: true, length: { maximum: 50})

  # define regex for email (defined as a constant, starting with upper case letters)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # validation: email cannot be blank, and must follow email format
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: true})

  # this creates password, password_confirmation, password_digest attributes, and authenticate method.
  has_secure_password

  # pwd should be at least 6 chars
  validates :password, length: { minimum: 6 }


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # ? stops sql injection (acts as sanitizer)
    # this displays the user's own post
    # Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
