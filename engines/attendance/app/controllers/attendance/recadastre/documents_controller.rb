require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class DocumentsController < ApplicationController
      
      before_action :set_ticket
      before_action :set_context

      def new
        @service = Core::Attendance::RecadastreService.new(cadastre: current_cadastre, ticket: @ticket, context: @context)
        @service.set_required_documents
        @context = @service.context
      end

      def create
        if @context.update_attributes!(set_params)
          @context.update(status: 2)
          flash[:success] = "Atualização realizada com sucesso!"
          redirect_to recadastre_path
        else
          redirect_to action: :new
        end
      end

      private

      def set_params
        params.fetch(:attendance_ticket_context_action, {}).permit(rg_uploads_attributes: [:upload_path, :id, :_destroy])
      end

      def set_cadastre_mirror
        @cadastre_mirror = Core::Attendance::CadastreForm.find(@ticket.cadastre_mirror_id)
      end

      def set_context
        @context = Core::Attendance::TicketContextAction.find(params[:context_id])
      end

      def set_ticket
        @ticket = current_cadastre.tickets.find(params[:ticket_id])
        @ticket = Core::Attendance::TicketPolicy.new(@ticket)
        @ticket = Core::Attendance::TicketPresenter.new(@ticket)
      end
    end
  end
end