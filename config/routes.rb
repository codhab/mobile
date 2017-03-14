Rails.application.routes.draw do

  root 'candidate/home#show'

  mount Attendance::Engine => '/attendance', as: :attendance
  mount Candidate::Engine  => '/candidate',  as: :candidate
  
end
