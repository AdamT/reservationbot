class Reservation < ActiveRecord::Base
  belongs_to :table

  default_scope -> { order('time ASC') }

  scope :within_this_time, ->(new_time) {
    where('time between ? and ?', earliest, latest)
  }

  def self.setup(params)
    @reservation_obj = ReservationData.new(params)
    ReservationSetup.new(@reservation_obj).setup
  end

  def is_valid?
    return false unless errors.empty?
    true
  end

  private

  def self.earliest
    @reservation_obj.time - 1.hour - 59.minute
  end

  def self.latest
    @reservation_obj.time + 1.hour + 59.minute
  end

end
