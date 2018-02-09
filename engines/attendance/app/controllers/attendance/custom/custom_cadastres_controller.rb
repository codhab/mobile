require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomCadastresController < CustomApplicationController
      before_action :set_ticket
      before_action :set_cadastre_mirror

      def edit; end

      def update
        @cadastre_mirror.update(set_params)

        redirect_to new_custom_custom_ticket_custom_document_path(type: 'cadastre')
      end

      def document_edit
        @document = nil
      end

      def document_update
        @document = nil
      end

      private

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def set_cadastre_mirror
        @cadastre_mirror = @ticket.cadastre_mirror
      end

      def set_params
        params.require(:custom_cadastre_mirror).permit(:rg, :born, :born_uf, :place_birth, :gender, :civil_state_id, :rg_org, :rg_uf, :arrival_df, :special_condition_id, :special_condition_type_id, :nis, :cid, :adapted_property, :mother_name)
      end

    end
  end
end
