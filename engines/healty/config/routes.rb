Healty::Engine.routes.draw do
  root 'dashboard#index'

  resources :vois do
    resources :voi_activities, as: :activities
    resources :voi_documents,  as: :documents
  end
  resources :unit_vois
  get 'block', to: 'vois#block', as: 'block'
  get 'group', to: 'vois#group', as: 'group'
  get 'unit',  to: 'vois#unit',  as: 'unit'

  resources :sealing_addresses do
    resources :sealing_documents
  end
end
