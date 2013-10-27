class Reservation < ActiveRecord::Base
  belongs_to :table

  scope :within_this_time, ->(new_time) {
    where('time between ? and ?', new_time - 1.hour - 59.minute, new_time + 1.hour + 59.minute)
  }

  class << self
    attr_accessor :reservation_obj

    def setup(params)
      @reservation_obj = build_reservation_object(params)
      if reservation_obj.group_size <= Table.most_seats && is_not_weekend?(reservation_obj.time) && is_available?(reservation_obj)
        tables = Table.can_be_used(reservation_obj.group_size) & open_tables.sort! {|open_table| open_table.seats }

        @reservation = tables.first.reservations.create(
          time: reservation_obj.time,
          group_size: reservation_obj.group_size
        )
      else
        @reservation = Reservation.new
        @reservation.errors[:base] << 'Group too large'
        @reservation.errors[:base] << 'No tables available'
      end

      @reservation

    end
  end

  def is_valid?
    return false unless self.errors.empty?
    true
  end

  def self.is_not_weekend?(time)
    wday = time.strftime('%A')
    return false if wday == 'Saturday' || wday == 'Sunday'
    true
  end

  def self.is_available?(reservation_obj)
    if open_tables.count == Table.order('created_at desc').count
      can_add =  true
    elsif open_tables.count == 1 && reservation_obj.group_size <= open_tables.first.seats
      can_add = true
    else
      can_add = false
    end

    can_add
  end
  private_class_method :is_available?

  def self.open_tables
    #current_reservations = within_this_time(reservation_obj.time).all
    current_reservations = within_this_time(reservation_obj.time).to_a
    current_reservations.empty? ? Table.all : Table.all - current_reservations.collect {|reservation| reservation.table }
  end

  def self.build_reservation_object(params)
    ReservationData.new(params)
  end
  private_class_method :build_reservation_object

end
