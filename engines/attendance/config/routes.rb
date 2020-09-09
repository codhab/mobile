Attendance::Engine.routes.draw do

  #resources :chats
  #resources :chat_comments
  #get 'new_comment',          to: 'chat_comments#new_comment',          as: :new_comment
  #post 'create_comment',       to: 'chat_comments#create_comment',       as: :create_comment

  resources :forms, only: [:new, :create, :show]

  resources :avatars, only: :update
  resources :requeriments
  resources :notifications
  resources :tickets

  resources :tickets do

    get '/confirm/:action_id',          to: 'tickets#confirm',          as: :confirm
    get '/open/:action_id',             to: 'tickets#open',             as: :open
    get '/close',                       to: 'tickets#close',            as: :close
    get '/close_action/:action_id',     to: 'tickets#close_action',     as: :close_action
    get '/close_dependent/:action_id',  to: 'tickets#close_dependent',  as: :close_dependent

    get '/update_cadastre',  to: 'tickets#update_cadastre',   as: :update_cadastre
    get '/update_dependent', to: 'tickets#update_dependent',  as: :update_dependent
    get '/update_income',    to: 'tickets#update_income',     as: :update_income
    get '/update_contact',   to: 'tickets#update_contact',    as: :update_contact

    get '/continue_cadastre/:action_id',  to: 'tickets#continue_cadastre',   as: :continue_cadastre
    get '/continue_dependent/:action_id', to: 'tickets#continue_dependent',  as: :continue_dependent
    get '/continue_income/:action_id',    to: 'tickets#continue_income',     as: :continue_income
    get '/continue_contact/:action_id',   to: 'tickets#continue_contact',    as: :continue_contact

    resources :cadastres
    resources :dependents
    resources :incomes
    resources :contacts

    resources :action, only: nil do
      resources :documents
    end

  end

  resources :indications, only: [:index] do
    get 'accept'
    get 'new_decline'
    get 'create_decline'
  end

  resources :open_doors do
    get 'delete'
  end


  # = CONTIGENCIA

  namespace :custom do
    resources :custom_tickets do
      get 'cadastre'
      get 'dependent'
      get 'income'
      get 'contact'
      get 'document'

      get 'term_one'
      get 'term_two'
      get 'term_three'

      get 'message'

      resources :custom_cadastres
      resources :custom_dependents
      resources :custom_dependent_incomes
      resources :custom_incomes
      resources :custom_contacts
      resources :custom_documents
    end
    resources :custom_images
  end

end
