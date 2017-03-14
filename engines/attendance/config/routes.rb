Attendance::Engine.routes.draw do

  resources :chats
  resources :requeriments
  
  resources :tickets, only: [:new, :index, :show] do 
    collection do 
      get 'pre_create/:context_id',  to: 'tickets#pre_create', as: 'pre_create'
      get 'close/:ticket_id',        to: 'tickets#close',      as: 'close'
      get 'create/:context_id',      to: 'tickets#create',     as: 'create'
    end
  end

  get  'cadastre/edit/:ticket_id',   to: 'cadastres#edit',   as: 'edit_cadastre'
  put  'cadastre/update/:ticket_id', to: 'cadastres#update', as: 'update_cadastre'

  get  'document/edit/:ticket_id',         to: 'documents#edit',    as: 'edit_document'
  put  'document/update/:ticket_id', to: 'documents#update',  as: 'update_document'
end
