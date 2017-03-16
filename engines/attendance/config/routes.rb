Attendance::Engine.routes.draw do

  resources :chats do
    resources :chat_comments
  end

  resources :requeriments
  resources :notifications

  resources :contexts, only: [:new] do 
    get 'create', to: 'contexts#create'
  end

  resources :tickets, only: [:index, :show] do
    get 'resume',       to: 'tickets#resume',     as: 'resume'
    
    get 'pre_conclude', to: 'tickets#pre_conclude', as: 'pre_finish'
    get 'conclude',     to: 'tickets#conclude',     as: 'finish'

    get 'delete', to: 'tickets#delete', as: 'delete'

    resources :dependents
    resources :cadastres,   only: [:edit, :update]
    resources :contacts,    only: [:edit, :update]
    resources :incomes,     only: [:edit, :update]

    resources :documents, only: [:edit, :update]
  end


end
