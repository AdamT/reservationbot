Reservationbot::Application.routes.draw do
  get "reservations/new"
  get "reservations/index"

  resources :reservations

  root "reservations#new"
end
