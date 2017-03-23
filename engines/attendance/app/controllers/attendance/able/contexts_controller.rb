require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class ContextsController < ApplicationController
      before_action :set_ticket

      def index
      end
   
    end
  end
end