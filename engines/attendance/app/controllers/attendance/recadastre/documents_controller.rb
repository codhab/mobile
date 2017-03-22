require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class DocumentsController < ApplicationController
      before_action :set_ticket

      def new
        @service = Core::Attendance::RecadastreService.new(ticket: @ticket)
        @ticket  = @service.document_required params[:context_id]
      end

      def create
        if @ticket.update(set_params)
          @service = Core::Attendance::RecadastreService.new(ticket: @ticket)
          @service.close_by_candidate
          redirect_to recadastre_tickets_path
        else
          render action: :new
        end
      end

      private

      def set_params
        params.fetch(:attendance_ticket, {})
              .permit(rg_uploads_attributes: [:upload_path, :id, :_destroy])
      end

      def set_ticket
        @ticket = Core::Attendance::Ticket.find(params[:ticket_id])
      end
      
    end
  end
end