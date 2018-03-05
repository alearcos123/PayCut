Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  resources :charges

  resources :password_resets,     only: [:new, :create, :edit, :update]
  get 'sessions/new'
  resources :customers
  resources :barbers
  resources :appointments
  root :to => 'barbers#index'
  get '/search' => 'barbers#search'
  get '/barber/appointment' => 'barbers#appointment'

  get '/customers/new' => 'customers#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  get '/day_schedule/new', to: 'day_schedule#new'
  post '/day_schedules', to: 'day_schedule#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
