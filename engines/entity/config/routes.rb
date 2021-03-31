Entity::Engine.routes.draw do

  #session login
  #/entity/auth?cnpj=xxxxxxx&password=xxxxxxxx
  post 'auth', to: 'sessions#new'

  root 'dashboard#index'

  resources :dashboard
  resources :cadastres

  resources :interests, as: :entity_interests do
    get 'send_mail'
  end


  resources :forms
  resources :indications do
    get 'accept_term'
    get 'confirm'
    get 'cancel'
  end

  get '/candidates', to: 'candidates#index'

  resources :provisional_cadastres, only: [:new, :show, :create]

  get  '/remember', to: 'remember#new'
  post '/remember', to: 'remember#create'

  get  '/update_password', to: 'remember#edit'
  put  '/update_password', to: 'remember#update'

  resources :contacts
  resources :requeriments
  resources :raffles do
    get 'address'
    get 'entity'
    get 'winner'
  end

  #resources :chats
  #resources :chat_comments
  #get 'new_comment',          to: 'chat_comments#new_comment',          as: :new_comment
  #post 'create_comment',       to: 'chat_comments#create_comment',       as: :create_comment

end
