require_dependency 'application_controller'
require_dependency 'application_helper'

module Attendance
  class ApplicationController < ApplicationController
    protect_from_forgery with: :exception

    helper ::ApplicationHelper
  end
end
