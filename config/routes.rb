Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  use_doorkeeper

  namespace :api do
    get 'ping', to: 'general#ping'
    post 'citas/disponibles', to: 'citas#disponibles'

    patch 'usuarios/filtrar', to: 'usuarios#filtrar'
    resources :usuarios, only: %i[show create update destroy]
    patch 'pacientes/filtrar', to: 'pacientes#filtrar'
    resources :pacientes, only: %i[show create update destroy]
    resources :medicos, except: %i[new edit index] do
      collection do
        patch 'filtrar', to: 'medicos#filtrar' # PATCH para filtrar médicos
      end
      resources :horario_medicos, only: %i[index create destroy]
      resources :especialidades, only: %i[index create destroy]
    end
    resources :citas, except: %i[new edit]

    post 'login', to: 'sessions#create'
  end
end
