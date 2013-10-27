class ReservationSetup

  attr_accessor :reservation_data, :reservation

  def initialize(reservation_data)
    @reservation_data = reservation_data
  end

  def setup
    if reservation_requirements_met?
      @reservation = target_table.reservations.create(
        time: reservation_data.time,
        group_size: reservation_data.group_size
      )
    else
      @reservation = Reservation.new
      @reservation.errors[:base] << 'Group too large'
      @reservation.errors[:base] << 'No tables available'
    end

    return reservation
  end

  private

  def reservation_requirements_met?
    group_not_too_big? && is_not_weekend? && tables_available?
  end

  def group_not_too_big?
    reservation_data.group_size <= Table.most_seats
  end

  def is_not_weekend?
    wday = reservation_data.time.strftime('%A')
    return false if wday == 'Saturday' || wday == 'Sunday'
    true
  end

  def tables_available?
    if open_tables.count == Table.order('created_at desc').count
      return true
    elsif open_tables.count == 1 && reservation_data.group_size <= open_tables.first.seats
      return true
    else
      return false
    end
  end

  def open_tables
    if current_reservations.empty?
      Table.all
    else
      Table.all - current_reservations.collect {|reservation| reservation.table }
    end
  end

  def current_reservations
    Reservation.within_this_time(reservation_data.time).to_a
  end

  def target_table
    tables = Table.can_be_used(reservation_data.group_size) & open_tables.sort! {|open_table| open_table.seats }
    tables.first
  end
end
