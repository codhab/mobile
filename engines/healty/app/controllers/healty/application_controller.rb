require_dependency 'person/application_controller'

module Healty
  class ApplicationController < Person::ApplicationController # :nodoc:
    protect_from_forgery with: :exception
  end
end
