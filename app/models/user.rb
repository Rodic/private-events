class User < ActiveRecord::Base

  before_save { self.email = email.downcase }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :email, length: { maximum: 50 }, format: { with: EMAIL_REGEX, message: "Invalid email format" }
  validates :password, length: { minimum: 7 }
  
  has_secure_password
end
