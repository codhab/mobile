Regularization::Engine.routes.draw do
  root 'home#index'
  resources :solicitations do
    resources :solicitation_documents,  as: :documents
    resources :solicitation_requests
  end

  get 'error',     to: 'solicitations#error',            as: 'error'
  get 'complete',  to: 'solicitations#complete',         as: 'complete'
  get 'search',    to: 'solicitation_monitoring#index',  as: 'monitoring'
  get 'block',     to: 'solicitations#block',            as: 'block'
  get 'group',     to: 'solicitations#group',            as: 'group'
  get 'unit',      to: 'solicitations#unit',             as: 'unit'
  # get 'by_cpf',    to: 'solicitation_monitoring#index'
end
