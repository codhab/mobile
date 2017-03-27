Entity::Engine.routes.draw do
  root 'cadastres#index'
  resources :cadastres, only: [:show] do
    get '/search', to: 'cadastres#search', as: :search, on: :collection
  end
end
