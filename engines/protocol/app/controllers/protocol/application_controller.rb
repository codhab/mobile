require_dependency 'application_controller'
require_dependency 'application_helper'

module Protocol
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end
end
