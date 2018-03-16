require_dependency 'application_controller'

module Healty
  class ApplicationController < ApplicationController # :nodoc:
    protect_from_forgery with: :exception
  end
end
