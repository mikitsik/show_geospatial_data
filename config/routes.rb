Rails.application.routes.draw do
  draw :api
  resources :tickets, only: [:show]
  root "tickets#index"
end
