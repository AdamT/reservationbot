class ReservationData

  attr_accessor :time, :group_size

  def initialize(params)

   @group_size = params[:reservation][:group_size].to_i

    @time = Date.parse(params[:reservation][:time]) + 
      params[:hours].to_i.hours +
      params[:minutes].to_i.minutes
  end
end
