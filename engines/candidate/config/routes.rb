Candidate::Engine.routes.draw do

  resources :cadastres, only: [:show]
  resources :notifications
  
end
