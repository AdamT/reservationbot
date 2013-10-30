class Reservation < ActiveRecord::Base

  belongs_to :table

  default_scope -> { order('time ASC') }

  scope :within_this_time, ->(time) {
    where('time between ? and ?', time - time_range, time + time_range)
  }

  def is_valid?
    return false unless errors.empty?
    true
  end

  private

  def self.time_range
    1.hour + 59.minutes
  end

end
