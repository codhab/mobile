Person::Engine.routes.draw do
  root 'home#show'

  resources :vocations
  resources :allowances

  resources :wallets do 
    collection do 
      get 'by_city'
      get 'by_block'
    end
  end
end
