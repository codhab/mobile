Attendance::Engine.routes.draw do

  resources :chats do
    resources :chat_comments
  end

  resources :requeriments
  resources :notifications
  resources :tickets

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
      
      resources :dependents
      resources :documents
    end
  end


end
