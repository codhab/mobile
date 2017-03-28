Attendance::Engine.routes.draw do

  resources :chats do
    resources :chat_comments
  end

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

=begin
  namespace :recadastre do 
    
    get '/', to: 'tickets#new'
    
    resources :tickets, only: :new do 
      get 'pre_confirm', to: 'tickets#pre_confirm', as: :pre_confirm
      get 'confirm',     to: 'tickets#confirm',     as: :confirm

      resources :contexts, only: [:index, :new] do 
        resources :cadastres, only: [:show, :edit, :update] do
          get 'confirm', to: 'cadastres#confirm', as: :confirm
        end
        resources :contacts do
          get 'confirm', to: 'contacts#confirm',  as: :confirm
        end
        resources :incomes do
          get 'confirm', to: 'incomes#confirm',   as: :confirm
        end
        resources :dependents do
          get 'confirm', to: 'dependents#confirm',as: :confirm
        end
        
        resources :documents, only: [:new, :create]
      end

    end
  end

  namespace :able do 
    resources :tickets, only: [:index, :new] do 
      resources :contexts, only: [:index, :new] do 
        resources :cadastres
        resources :contacts
        resources :incomes
        resources :dependents do 
          get 'confirm', to: 'dependents#confirm',as: :confirm
        end
        resources :documents        
      end
    end

  end

  namespace :convoked do 
    resources :tickets do 
      resources :contexts do 
        resources :cadastres
        resources :contacts
        resources :incomes
        resources :dependents
        resources :documents        
      end
    end
  end
  namespace :recadastre do 
    resources :tickets do 
      get 'pre_create',   to: 'tickets#pre_create', as: :pre_create, on: :collection
      get 'pre_close',    to: 'tickets#pre_close',  as: :pre_close
      get 'close',        to: 'tickets#close',      as: :close
      
      resources :cadastres do 
        get 'context_new', to: 'cadastres#context_new', as: :context_new, on: :collection
        get 'confirm',     to: 'cadastres#confirm',     as: :confirm, on: :collection
      end
      
      resources :incomes do 
        get 'context_new', to: 'incomes#context_new', as: :context_new, on: :collection
        get 'confirm',     to: 'incomes#confirm',     as: :confirm, on: :collection
      end
      
      resources :dependents do 
        get 'context_new', to: 'dependents#context_new', as: :context_new, on: :collection
        get 'confirm',     to: 'dependents#confirm',     as: :confirm, on: :collection
      end

       
      resources :contacts do 
        get 'context_new', to: 'contacts#context_new', as: :context_new, on: :collection
        get 'confirm',     to: 'contacts#confirm',     as: :confirm, on: :collection
      end     
      
      resources :contexts do 
        resources :documents
      end
      
    end
  end
=end

end
