Rails.application.routes.draw do
  resources :charges


  get 'sessions/new'
  resources :customers
  resources :barbers
  resources :appointments
  root :to => 'barbers#index'
  get '/search' => 'barbers#search'
  get '/barber/appointment' => 'barbers#appointment'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
