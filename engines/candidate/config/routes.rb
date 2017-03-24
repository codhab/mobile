Candidate::Engine.routes.draw do

  root 'home#show'

  resources :cadastres, only: [:show] do
    get '/search', to: 'cadastres#search', as: :search, on: :collection
    collection do  
      get 'detail',     to: 'cadastres#detail'
      get 'pontuation', to: 'cadastres#pontuation'
      get 'dependent',  to: 'cadastres#dependent'
      get 'occurrence', to: 'cadastres#occurrence'
      get 'entity',     to: 'cadastres#entity'
      get 'situation',  to: 'cadastres#situation'
      get 'address',    to: 'cadastres#address'
      get 'schedule',   to: 'cadastres#schedule'
      get 'document',   to: 'cadastres#document'
    end
  end
  
end
