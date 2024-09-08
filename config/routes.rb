Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Rutas de la API
  namespace :api do
    namespace :v1 do
      # Rutas de productos
      resources :products, only: [:index, :show, :create, :update, :destroy]

      # Rutas de órdenes
      resources :orders, only: [:index, :show, :create, :update, :destroy]

      # Rutas de usuario y perfil
      get 'me', to: 'me#show'
      put 'me', to: 'me#update'   # Agregar ruta para actualizar el perfil del usuario
      patch 'me', to: 'me#update' # Permite actualizaciones parciales
      
      resources :profiles, only: [:create, :show, :update, :destroy]
    end
  end

  use_doorkeeper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
