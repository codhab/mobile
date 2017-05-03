Rails.application.routes.draw do

  root 'candidate/home#show'

  get '404', :to => 'application#page_not_found'

  get   '/notifications', to: 'notifications#index'
  post  '/auth',          to: 'sessions#new'

  get  '/authenticate',          to: 'sessions#authenticate'



  mount Attendance::Engine => '/attendance', as: :attendance
  mount Candidate::Engine  => '/candidate',  as: :candidate
  mount Entity::Engine     => '/entity',     as: :entity
  mount Portal::Engine     => '/portal',     as: :portal

end
