Rails.application.routes.draw do

  mount Attendance::Engine => '/attendance', as: :attendance
  
end
