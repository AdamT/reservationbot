class ReservationData

  attr_accessor :time, :group_size

  def initialize(params)
    @params     = params
    @time       = build_datetime
    @group_size = build_group_size
  end

  private

  def build_group_size
    params[:reservation][:group_size].to_i
  end

  def build_datetime
    date + hours + minutes
  end

  def date
    Date.parse(params[:reservation][:time])
  end

  def hours
    params[:hours].to_i.hours
  end

  def minutes
    params[:minutes].to_i.minutes
  end

  def params
    @params
  end
end
