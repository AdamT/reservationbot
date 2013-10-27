class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.setup(params)

    if @reservation.is_valid?
      redirect_to reservations_path, notice: "Reservation booked!"
    else
      render :new
    end
  end

  def index
  end
end
