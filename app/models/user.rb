class User < ActiveRecord::Base

  # before saving the user object to the database, turn email to all lowercase
  before_save { self.email = email.downcase }

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

end
