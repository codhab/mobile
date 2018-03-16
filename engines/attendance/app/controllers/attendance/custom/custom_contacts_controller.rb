require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomContactsController < CustomApplicationController
      before_action :set_ticket
      before_action :set_cadastre_mirror

      def edit; end

      def update
        if @contact.update(set_params)
          @ticket.update(action_four: true)
          redirect_to custom_custom_tickets_path(type: 'cadastre')
        else
          render action: :edit
        end
      end

      private

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def set_cadastre_mirror
        @cadastre_mirror = @ticket.cadastre_mirror
        @contact = CustomContact.find(@cadastre_mirror.id)
      end

      def set_params
        params.require(:custom_contact).permit(:email, :telephone, :telephone_optional, :celphone, :address, :city_id, :cep)
      end

    end
  end
end
