Portal::Engine.routes.draw do

  resources :posts, path: 'noticies'

  get 'tecnhical-assistence', to: 'custom_pages#tecnhical-assistence'
  
end
