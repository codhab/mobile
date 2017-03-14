require_dependency 'application_controller'

module Candidate
  class ApplicationController < ApplicationController
    protect_from_forgery with: :exception

  end
end
