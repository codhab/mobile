require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class TicketsController < ApplicationController

      def index
        @service = Core::Attendance::RecadastreService.new(cadastre: current_cadastre)
        @service.create
        
        @ticket = @service.ticket.presenter
        
        redirect_to main_app.root_path if @ticket.nil?
      end

      def pre_create
      end
      
    end
  end
end