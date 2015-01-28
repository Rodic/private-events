class Invitation < ActiveRecord::Base

  validates :event_id,     presence: true
  validates :recipient_id, presence: true

  belongs_to :event
  belongs_to :recipient, class: User
  has_one :sender, through: :event, source: :creator, class: User
end
