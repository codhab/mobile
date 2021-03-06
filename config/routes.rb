Rails.application.routes.draw do

  root 'candidate/home#show'

  get '404', :to => 'application#page_not_found'

  get   '/notifications', to: 'notifications#index'
  post  '/auth',          to: 'sessions#new'

  get  '/authenticate',   to: 'sessions#authenticate'
  get  '/logout',         to: 'sessions#logout'

  mount Attendance::Engine           => '/attendance',              as: :attendance
  mount Candidate::Engine            => '/candidate',               as: :candidate
  mount Entity::Engine               => '/entity',                  as: :entity
  mount Person::Engine               => '/person',                  as: :person
  mount Portal::Engine               => '/portal',                  as: :portal
  mount Protocol::Engine             => '/protocol',                as: :protocol
  mount Social::Engine               => '/social',                  as: :social
  mount Healty::Engine               => '/sistema-imoveis',         as: :healty
  mount Regularization::Engine       => '/regularization',          as: :regularization
  mount TechnicalAssistance::Engine  => '/technical_assistance',    as: :technical_assistance
end
