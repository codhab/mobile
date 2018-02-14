require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomDependentIncomesController < CustomApplicationController
      before_action :set_ticket
      before_action :set_cadastre_mirror
      before_action :set_dependent_mirror

      def edit; end

      def update
        if @dependent.update(set_params)
          redirect_to new_custom_custom_ticket_custom_document_path(type: 'income', dependent_mirror_id: @dependent.id)
        else
          render action: :edit
        end
      end

      private

      def set_params
        params.require(:custom_dependent_mirror).permit(:income)
      end

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def set_cadastre_mirror
        @cadastre_mirror = @ticket.cadastre_mirror
      end

      def set_dependent_mirror
        @dependent = @cadastre_mirror.dependent_mirrors.find(params[:id])
        @dependent = Attendance::CustomDependentIncome.find(@dependent)
      end
    end
  end
end
