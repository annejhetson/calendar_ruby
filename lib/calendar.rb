class Calendar < ActiveRecord::Base
  has_many :events

  def todays_events(calendar)
    calendar.events.each do |event|
      if event.start.to_s[0..9] == Date.today.to_s
        calendar.todays_events << event
      end
    end
  end
end
