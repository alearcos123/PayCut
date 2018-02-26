Rails.application.routes.draw do
  get 'sessions/new'

  resources :customers
  resources :barbers
  resources :appointments
  root 'customers#new'
  get '/search' => 'barbers#search'
  get '/barber/appointment' => 'barbers#appointment'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
