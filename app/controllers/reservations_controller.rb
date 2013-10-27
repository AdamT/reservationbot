class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new
    setup_response = Reservation.setup(params)

    if setup_response.is_valid?
      redirect_to reservations_path, notice: "Reservation booked!"
    else
      render :new
    end
  end

  def index
  end
end
