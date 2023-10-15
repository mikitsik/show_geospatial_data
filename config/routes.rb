Rails.application.routes.draw do
  draw :api
  resources :tickets, only: [:show]
  get "about/about", to: "about#about", as: "about"
  root "tickets#index"
end
