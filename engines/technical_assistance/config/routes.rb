TechnicalAssistance::Engine.routes.draw do
  root 'home#index'
  get 'melhorias', to: 'home#melhorias', as:'melhorias'
  get 'entenda', to: 'home#entenda', as: 'entenda'
  resources :pre_registers
  get 'done', to: 'home#done', as: 'done'

  get 'burgh', to: 'pre_registers#burgh', as: 'burgh'
end
