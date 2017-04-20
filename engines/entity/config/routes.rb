Entity::Engine.routes.draw do
  
  #session login
  #/entity/auth?cnpj=xxxxxxx&password=xxxxxxxx
  post 'auth', to: 'sessions#new'

  root 'dashboard#index'

  resources :dashboard
  resources :cadastres
  resources :forms
  resources :contacts
end
