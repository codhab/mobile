Rails.application.routes.draw do
  mount Person::Engine => "/person"
end
