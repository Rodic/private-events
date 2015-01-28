class Event < ActiveRecord::Base

  validates :title,       presence: true, length: { maximum: 140 }
  validates :date,        presence: true
  validates :location,    presence: true
  validates :description, length: { maximum: 800 }

  belongs_to :creator, class: User
  has_many   :schedules
  has_many   :attendees, through: :schedules, source: :user
  has_many   :invitations

  scope :past,     -> { where("date < ?", Time.now) }
  scope :upcoming, -> { where("date > ?", Time.now) }
end
