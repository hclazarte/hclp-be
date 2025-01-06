Rails.application.routes.draw do
  post '/session', to: 'sessions#create'
  post '/session/verify', to: 'sessions#verify_otp'
  delete 'logout', to: 'sessions#destroy'  

  # Rutas de la API
  namespace :api do
    namespace :v1 do
      # Rutas de productos
      resources :products, only: [:index, :show, :create, :update, :destroy]

      # Rutas de órdenes
      resources :orders, only: [:index, :show, :create, :update, :destroy]

      # Rutas de mis órdenes
      get 'my_orders', to: 'my_orders#index'
      post 'my_orders', to: 'my_orders#create'

      # Rutas de usuario y perfil
      get 'me', to: 'me#show'
      put 'me', to: 'me#update'   # Agregar ruta para actualizar el perfil del usuario
      patch 'me', to: 'me#update' # Permite actualizaciones parciales

      # Agregar todas las acciones para profiles, incluido index
      resources :profiles, only: [:index, :create, :show, :update, :destroy]
      
      # Rutas para facturas
      resources :invoices, only: [:index, :show, :create]
    end
  end
end
