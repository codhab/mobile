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
  

end
