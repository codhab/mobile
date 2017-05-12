require_dependency 'application_controller'

module Person
  class ApplicationController < ApplicationController
    protect_from_forgery with: :exception
  end
end
