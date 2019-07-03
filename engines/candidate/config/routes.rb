Candidate::Engine.routes.draw do

  root 'home#show'

  get 'accept', to: 'home#accept', as: 'accept'
  get 'form',   to: 'home#form',   as: 'form'
  get 'not_accept', to: 'home#not_accept', as: 'not_accept'
  put 'not_accepted', to: 'home#not_accepted'
  get 'help', to: 'home#help'
  resources :requeriments
  resources :legal_rents, only: [:new]
  resources :enterprises, only: [:new, :show, :create]
  get 'success', to: 'enterprises#success', as: 'success'
  resources :cadastres, only: [:show] do
    get '/search', to: 'cadastres#search', as: :search, on: :collection
    get '/result', to: 'cadastres#result', as: :result, on: :collection

    collection do
      get 'detail',       to: 'cadastres#detail'
      get 'pontuation',   to: 'cadastres#pontuation'
      get 'dependent',    to: 'cadastres#dependent'
      get 'occurrence',   to: 'cadastres#occurrence'
      get 'entity',       to: 'cadastres#entity'
      get 'situation',    to: 'cadastres#situation'
      get 'address',      to: 'cadastres#address'
      get 'schedule',     to: 'cadastres#schedule'
      get 'document',     to: 'cadastres#document'
      get 'indication',   to: 'cadastres#indication'
    end
  end

end
