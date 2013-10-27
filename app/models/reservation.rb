class Reservation < ActiveRecord::Base
  belongs_to :table

  default_scope order('time ASC')
  scope :within_this_time, ->(new_time) {
    where(
      'time between ? and ?',
      new_time - 1.hour - 59.minute, new_time + 1.hour + 59.minute
    )
  }

  def self.setup(params)
    @reservation_obj = ReservationData.new(params)
    ReservationSetup.new(@reservation_obj).setup
  end

  def is_valid?
    return false unless errors.empty?
    true
  end

end
