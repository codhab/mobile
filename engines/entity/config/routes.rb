Entity::Engine.routes.draw do
  
  #session login
  #/entity/auth?cnpj=xxxxxxx&password=xxxxxxxx
  get 'auth', to: 'sessions#new'

  root 'dashboard#index'

  resources :dashboard
  resources :cadastres
  resources :forms
end
