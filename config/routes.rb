Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  use_doorkeeper

  namespace :api do
    get "ping", to: "general#ping"
    get "citas/disponibles", to: "citas#disponibles"

    resources :usuarios, except: [ :new, :edit ]
    resources :pacientes, except: [ :new, :edit ]
    resources :medicos, except: [ :new, :edit ] do
      resources :horario_medicos, only: [ :index, :create, :destroy ]
      resources :especialidades, only: [ :index, :create, :destroy ]
    end
    resources :citas, except: [ :new, :edit ]

    post "login", to: "sessions#create"
  end
end
