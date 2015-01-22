class Event < ActiveRecord::Base

  validates :title,       presence: true, length: { maximum: 140 }
  validates :date,        presence: true
  validates :location,    presence: true
  validates :description, length: { maximum: 800 }
  validate :date_in_future

  belongs_to :creator, class: User

  def date_in_future
    errors.add(:event_in_past, "Date can't be in past") if date && date < Time.now
  end

end
