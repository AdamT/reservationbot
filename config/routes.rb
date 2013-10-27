Reservationbot::Application.routes.draw do
  get "reservations/new"
  get "reservations/index"

  resources :reservations, only: [:new, :create, :index]

  root "reservations#index"
end
