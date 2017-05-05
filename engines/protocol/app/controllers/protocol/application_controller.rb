require_dependency 'application_controller'

module Protocol
  class ApplicationController < ApplicationController
    protect_from_forgery with: :exception

  end
end
