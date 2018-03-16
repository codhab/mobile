require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomIncomesController < CustomApplicationController
      before_action :set_ticket
      before_action :set_cadastre_mirror

      def index
      end

      def edit; end

      def update
        if @cadastre_mirror.update(set_params)
          redirect_to new_custom_custom_ticket_custom_document_path(type: 'income')
        else
          render action: :edit
        end
      end

      private

      def set_params
        params.require(:custom_cadastre_income).permit(:main_income)
      end

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def set_cadastre_mirror
        @cadastre_mirror = @ticket.cadastre_mirror
        @cadastre_mirror = Attendance::CustomCadastreIncome.find(@cadastre_mirror)
      end
    end
  end
end
