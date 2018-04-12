Regularization::Engine.routes.draw do
  root 'home#index'
  resources :solicitations do
    resources :solicitation_documents,  as: :documents
  end

  get 'block', to: 'solicitations#block', as: 'block'
  get 'group', to: 'solicitations#group', as: 'group'
  get 'unit',  to: 'solicitations#unit',  as: 'unit'
end
