Rails.application.routes.draw do
  resources :messages
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'about-me', to: 'pages#about'
  get 'contact', to: 'messages#new'
  get 'patient/profile', to: 'patients#profile'

  get 'searchPatients', to: 'search_patients#searchPatients', :as => 'searchPatients'
  post 'searchPatients', to: 'search_patients#findResults', :as => 'findReults'

  get 'patient/:id/edit', to: 'patients#edit', as: 'patient_edit_profile'
  # post 'patient/:id', to: 'patients#update', as: 'patient_update_profile'
  patch 'patient/:id', to: 'patients#update', as: 'patient_update_profile'

end
