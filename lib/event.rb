
class Event < ActiveRecord::Base

  # validate :future_check
  # private
  #   def future_check
  #     errors.add(:start, "End time must be before start time") unless
  #         :start < :end
  #   end

end
