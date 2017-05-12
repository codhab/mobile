Person::Engine.routes.draw do
  root 'home#show'

  resources :vocations
  resources :allowances
end
