Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Rutas de la API
  namespace :api do
    namespace :v1 do
      get 'orders/index'
      get 'orders/show'
      get 'orders/create'
      get 'orders/update'
      get 'orders/destroy'
      # Ruta de me devuelve el usuario conectado
      get 'me', to: 'me#show'
      resource :me, only: [:show]
      # Rutas de profile
      get 'current_profile', to: 'profiles#current_profile'
      resources :profiles, only: [:create, :show, :update, :destroy]
      # Rutas para orders
      resources :orders, only: [:index, :show, :create, :update, :destroy]
    end
  end

  use_doorkeeper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
