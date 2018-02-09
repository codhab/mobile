require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomIncomesController < CustomApplicationController
      before_action :set_ticket
      before_action :set_cadastre_mirror

      def index
        @income = @cadastre_mirror
        @incomes = @cadastre_mirror.dependent_mirrors
      end

      def edit; end

      def update
      end

      private

      def set_params
        params.require(:path).permit(:name)
      end

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def set_cadastre_mirror
        @cadastre_mirror = @ticket.cadastre_mirror
      end
    end
  end
end
