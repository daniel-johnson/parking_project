Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}

  root 'home#index'

  get "/what" => "home#what"

  resources :charges

  resources :parking_events

  resources :customers

  resources :payments

end
