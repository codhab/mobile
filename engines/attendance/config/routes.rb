Attendance::Engine.routes.draw do

  resources :chats do
    resources :chat_comments
  end
  resources :requeriments
  resources :notifications

  resources :tickets, only: [:new, :index, :show] do
    collection do
      get 'pre_create/:context_id',  to: 'tickets#pre_create', as: 'pre_create'
      get 'pre_finish/:ticket_id',   to: 'tickets#pre_finish', as: 'pre_finish'
      get 'finish/:ticket_id',       to: 'tickets#finish',     as: 'finish'
      get 'close/:ticket_id',        to: 'tickets#close',      as: 'close'
      get 'cancel/:ticket_id',       to: 'tickets#cancel',     as: 'cancel'
      get 'continue/:ticket_id',     to: 'tickets#continue',   as: 'continue'
      get 'create/:context_id',      to: 'tickets#create',     as: 'create'
    end
  end

  #cadastre
  get  'cadastre/edit/:ticket_id',   to: 'cadastres#edit',   as: 'edit_cadastre'
  put  'cadastre/update/:ticket_id', to: 'cadastres#update', as: 'update_cadastre'

  get  'document/edit/:ticket_id',   to: 'documents#edit',    as: 'edit_document'
  put  'document/update/:ticket_id', to: 'documents#update',  as: 'update_document'


  #dependent
  get  'dependents/:ticket_id',    to: 'dependents#index',  as: 'dependents'

  get  'dependent/new/:ticket_id',    to: 'dependents#new',     as: 'new_dependent'
  post 'dependent/create/:ticket_id', to: 'dependents#create',  as: 'create_dependent'

  get  'dependent/edit/:ticket_id/:dependent_id',   to: 'dependents#edit',   as: 'edit_dependent'
  put  'dependent/update/:ticket_id/:dependent_id', to: 'dependents#update', as: 'update_dependent'

  get     'dependent/remove/:ticket_id/:dependent_id',  to: 'dependents#remove',  as: 'remove_dependent'
  delete  'dependent/destroy/:ticket_id/:dependent_id', to: 'dependents#destroy', as: 'destroy_dependent'
  #income
  get  'income/edit/:ticket_id',   to: 'incomes#edit',   as: 'edit_income'
  put  'income/update/:ticket_id', to: 'incomes#update', as: 'update_income'


  #contact
  get  'contact/edit/:ticket_id',   to: 'contacts#edit',   as: 'edit_contact'
  put  'contact/update/:ticket_id', to: 'contacts#update', as: 'update_contact'
end
