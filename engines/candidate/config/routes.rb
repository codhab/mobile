Candidate::Engine.routes.draw do

  root 'home#show'

  resources :cadastres, only: [:show]
  
end
