Rails.application.routes.draw do
  resources :bookings
  resources :events
  resources :instructors
  resources :dance_styles
  resources :giraffes
  resources :tests
  resources :bookings 
  #get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
