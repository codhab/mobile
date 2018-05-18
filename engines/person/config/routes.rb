Person::Engine.routes.draw do
  root 'home#show'



  resources :vocations
  resources :panics
  resources :allowances
  get 'panic_stop', to: 'panics#panic_stop', as: 'panic_stop'

  resources :wallets do

    collection do
      get 'document/:id', to: 'wallets#document', as: :document
      get 'by_city'
      get 'by_block'
    end
  end
end
