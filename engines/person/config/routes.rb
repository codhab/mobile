Person::Engine.routes.draw do
  root 'home#show'

  
  
  resources :vocations
  resources :allowances

  resources :wallets do 
    
    collection do 
      get 'document/:id', to: 'wallets#document', as: :document
      get 'by_city'
      get 'by_block'
    end
  end
end
