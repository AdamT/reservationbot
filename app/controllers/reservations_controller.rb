class ReservationsController < ApplicationController
  before_action :reservation_service, only: [:create]

  def new
    @reservation = Reservation.new
  end

  def create
    #@reservation = Reservation.setup(params)
    @reservation = @service.setup(params)

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

  private

  def reservation_service(service = ReservationService.new)
    @service = service
  end
end
