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
    @two_person_table = Table.where(seats: 2).first
    @four_person_table = Table.where(seats: 4).first
  end
end
