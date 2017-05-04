Rails.application.routes.draw do
  mount Protocol::Engine => "/protocol"
end
