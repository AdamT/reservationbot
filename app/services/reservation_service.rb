class ReservationService

  attr_reader :data

  def setup(params)
    setup_data(params)

    if requirements_met?
      @reservation = Reservation.new(time: data.time, group_size: data.group_size)
      table.reservations << @reservation
    else
      @reservation = Reservation.new
      @reservation.errors[:base] << 'No tables available'
    end
    @reservation
  end

  private

  def setup_data(params)
    @data = ReservationData.new(params)
  end

  def requirements_met?
    right_group_size? && not_on_weekend? && tables_available?
  end

  def right_group_size?
    data.group_size <= Table.most_seats
  end

  def not_on_weekend?
    wday = data.time.strftime('%A')
    return false if wday == 'Saturday' || wday == 'Sunday'
    true
  end

  def tables_available?
    if open_tables.count == Table.order('created_at desc').count
      return true
    elsif open_tables.count == 1 && data.group_size <= open_tables.first.seats
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
    Reservation.within_this_time(data.time).to_a
  end

  def table
    tables = Table.can_be_used(data.group_size) & open_tables
    tables.first
  end
end
