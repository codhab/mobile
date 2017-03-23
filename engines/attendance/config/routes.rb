Attendance::Engine.routes.draw do

  resources :chats do
    resources :chat_comments
  end

  resources :requeriments
  resources :notifications
  resources :tickets

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
        resources :dependents
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
=begin
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
