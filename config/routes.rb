Rails.application.routes.draw do

  
  resources :user_holders do
   resources :treatments
   resources :medications
   resources :appointments
   resources :user_activities, except: [:update, :new, :create, :edit, :destroy]
  end

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :documentations, only: [:index, :new, :create, :destroy]
  resources :messages
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'about-me', to: 'pages#about'
  get 'contact', to: 'messages#contact'
  get 'contact_general', to: 'messages#contact_general'
  get 'patient/profile', to: 'patients#profile'
  get 'patient/setting', to: 'patients#setting'

  get 'searchPatients', to: 'search_patients#searchPatients', :as => 'searchPatients'
  post 'searchPatients', to: 'search_patients#searchPatients', :as => 'findReults'

  # Patient Profile routes.
  get 'patient/:id/new', to: 'patients#new', as: 'patient_new_profile'
  get 'patient/:id/edit', to: 'patients#edit', as: 'patient_edit_profile'
  get 'patient/:id', to: 'patients#show', as: 'patient'
  # post 'patient/:id', to: 'patients#update', as: 'patient_update_profile'
  patch 'patient/:id', to: 'patients#update', as: 'patient_update_profile'
  # Patient Setting routes
  get 'patient/:id/edit_setting', to: 'patients#edit_setting', as: 'patient_edit_setting'
  patch 'patient/:id/update_setting', to: 'patients#update_setting', as: 'patient_update_setting'
end
