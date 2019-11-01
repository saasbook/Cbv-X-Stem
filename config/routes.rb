Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'patient/profile', to: 'patients#profile'
  get 'searchPatients', to: 'search_patients#searchPatients', :as => 'searchPatients'
  post 'searchPatients', to: 'search_patients#findResults', :as => 'findReults'
end
