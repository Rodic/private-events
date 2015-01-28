class User < ActiveRecord::Base

  before_save { self.email = email.downcase }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :email, length: { maximum: 50 }, 
                    format: { with: EMAIL_REGEX, message: "Invalid email format" }
  validates :password, length: { minimum: 7 }
  
  has_many :events, foreign_key: :creator_id
  has_many :schedules
  has_many :attended_events, through: :schedules, source: :event
  has_many :invitations, foreign_key: :recipient_id

  has_secure_password

  def upcoming_events
    self.attended_events.upcoming
  end
  
  def previous_events
    self.attended_events.past
  end
end
