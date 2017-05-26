Entity::Engine.routes.draw do
  
  #session login
  #/entity/auth?cnpj=xxxxxxx&password=xxxxxxxx
  post 'auth', to: 'sessions#new'

  root 'dashboard#index'

  resources :dashboard
  resources :cadastres
  resources :forms
  resources :indications do 
    get 'confirm'
    get 'cancel'
  end

  resources :contacts
  resources :requeriments

  resources :chats
  resources :chat_comments
  get 'new_comment',          to: 'chat_comments#new_comment',          as: :new_comment
  post 'create_comment',       to: 'chat_comments#create_comment',       as: :create_comment

end
