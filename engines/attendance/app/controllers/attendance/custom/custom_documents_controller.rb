require_dependency 'attendance/custom/custom_application_controller'
module Attendance
  module Custom
    class CustomDocumentsController < CustomApplicationController
      before_action :set_ticket

      def new
        @document = Attendance::CustomTicketDocument.new
        @document.custom_ticket_id = @ticket.id
      end

      def create
        @document = Attendance::CustomTicketDocument.new(set_params)
        @document.custom_ticket_id    = @ticket.id
        @document.cadastre_mirror_id  = @ticket.cadastre_mirror_id
        @document.dependent_mirror_id = params[:dependent_mirror_id]
        @document.document_type_id    = params[:document_type_id]

        @document.save

        redirect_to new_custom_custom_ticket_custom_document_path(dependent_mirror_id: params[:dependent_mirror_id], type: params[:type], anchor: params[:anchor])
      end

      def destroy
        @ticket.documents.find(params[:id]).destroy

        redirect_to new_custom_custom_ticket_custom_document_path(dependent_mirror_id: params[:dependent_mirror_id], type: params[:type], anchor: params[:anchor])
      end

      private

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def set_params
        params.require(:custom_ticket_document).permit(:attachment)
      end
    end
  end
end
