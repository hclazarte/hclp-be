Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    resources :usuarios, except: [:new, :edit]
    resources :pacientes, except: [:new, :edit]
    resources :medicos, except: [:new, :edit] do
      resources :horario_medicos, only: [:index, :create, :destroy]
      resources :especialidades, only: [:index, :create, :destroy]
    end
    resources :citas, except: [:new, :edit]

    post 'login', to: 'sessions#create'
  end  
end
