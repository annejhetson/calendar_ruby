
class Event < ActiveRecord::Base
  validates :description, :presence => true
  validates :start, :presence => true

  validate :start_cannot_be_in_the_past
  belongs_to  :calendar

  def start_cannot_be_in_the_past
    if start != nil && start < Date.today
      errors.add(:start, "can't be in the past")
    end
  end

  def self.list_todays_events
    todays_events = []
    Event.all.each do |event|
      if event.start.to_s[0..9] == Date.today.to_s
        todays_events << event
      end
    end
    todays_events
  end

end

  # validates :end, :future_check => true
  # private
  #   def future_check
  #     errors.add(:end, "End time must be before start time") unless
  #         :start < :end
  #   end
