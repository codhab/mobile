require_dependency 'application_controller'

module Person
  class ApplicationController < ApplicationController
    protect_from_forgery with: :exception

    helper_method :current_user

    def current_user
      Core::Person::Staff.find(session[:staff_id])
    rescue
      nil
    end
  end
end
