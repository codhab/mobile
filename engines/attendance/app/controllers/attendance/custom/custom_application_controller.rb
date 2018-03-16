require_dependency 'application_controller'
require_dependency 'application_helper'

module Attendance
  module Custom
    class CustomApplicationController < ApplicationController
      protect_from_forgery with: :exception

      helper ::ApplicationHelper
    end
  end
end
