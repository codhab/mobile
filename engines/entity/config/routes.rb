Entity::Engine.routes.draw do
  root 'cadastres#index'
  
  resources :cadastres, only: [:index, :show] 

  resources :dashboard, only: [:index]

end
