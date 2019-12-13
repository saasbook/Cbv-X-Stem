Rails.application.routes.draw do

   devise_for :users, controllers: {
     confirmations: 'users/confirmations',
     # omniauth_callbacks: 'users/omniauth_callbacks',
     passwords: 'users/passwords',
     registrations: 'users/registrations',
     sessions: 'users/sessions',
     unlocks: 'users/unlocks',
   }

  resources :user_holders do
   resources :meetings
   resources :treatments
   resources :medications
   resources :appointments
   resources :documentations
   resources :messages
   resources :user_activities, except: [:update, :new, :create, :edit, :destroy]
  end

  delete 'treatment/destroy', to: 'treatments#destroy'
  post 'treatment/create', to: 'treatments#create'
  patch 'treatment/update', to: 'treatments#update'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # resources :documentations, only: [:index, :new, :create, :destroy]

  # get 'documentations/index'
  # get 'documentations/new'
  post 'documentations/create', to: 'documentations#create'
  patch 'documentations/update_landing'
  patch 'documentations/update', to: 'documentations#update'
  delete 'documentations/destroy', to: 'documentations#destroy'
  get 'documentations/information', to: 'documentations#information'
  get 'documentations/download_pdf'


  # admin
  get 'admin', to: 'admin#admin', as: 'admin'
  get 'admin/new', to: 'admin#new', as: 'create_doctor'
  get 'admin/delete', to: 'admin#delete', as: 'delete_doctor'
  post 'admin/create', to: 'admin#create', as: 'save_doctor'
  post 'admin/delete', to: 'admin#delete', as: 'delete_single'
  delete 'admin/delete/:id', to: 'admin#delete_single', as: 'delete_single_doctor'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'contact_general', to: 'messages#contact_general'
  get 'patient/profile', to: 'patients#profile'
  get 'patient/setting', to: 'patients#setting'
  # searchPatients routes
  get 'searchPatients', to: 'search_patients#searchPatients', as: 'searchPatients'
  post 'searchPatients', to: 'search_patients#searchPatients', as: 'findReults'

  # patient info page routes
  get 'patient/:id/info', to: 'patient_info#show', as: 'patient_info' 

  # Patient Profile routes.
  get 'patient/:id/new', to: 'patients#new', as: 'patient_new_profile'
  get 'patient/:id/edit', to: 'patients#edit', as: 'patient_edit_profile'
  get 'patient/:id', to: 'patients#show', as: 'patient'
  # post 'patient/:id', to: 'patients#update', as: 'patient_update_profile'
  patch 'patient/:id', to: 'patients#update', as: 'patient_update_profile'
  # Patient Setting routes
  get 'patient/:id/edit_setting', to: 'patients#edit_setting', as: 'patient_edit_setting'
  patch 'patient/:id/update_setting', to: 'patients#update_setting', as: 'patient_update_setting'

  # Doctor Schedule routes
  post '/user_holders/:user_holder_id/meetings_create', to: 'meetings#create', as: 'doctor_create_meeting'
  patch '/user_holders/:user_holder_id/update_meeting/:id', to: 'meetings#update', as: 'doctor_update_meeting'


  get '/patient/:id/show_doctor_schedule', to:'meetings#show_doctor_schedule', as:'show_doctor_schedule'
  # patch '/patient/:id/book/:meeting_id', to:'meetings#book', as: 'book_meeting'
  get '/patient/:id/book/:meeting_id', to:'meetings#book', as: 'book_meeting'
  patch '/patient/:id/book_edit/:meeting_id', to:'meetings#book_edit', as: 'book_meeting_edit'
  patch '/confirm/:meeting_id', to:'meetings#confirm', as: 'confirm_meeting'
  patch '/reject/:meeting_id', to:'meetings#reject', as: 'reject_meeting'
  get '/show_appointment/:meeting_id', to:'meetings#show_patient_appointment', as:'show_patient_appointment'


end
