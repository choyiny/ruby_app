class User < ActiveRecord::Base
  # validation: name and email cannot be blank
  validates(:name, presence: true)
  validates(:email, presence: true)
end
