require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class ContactsController < ApplicationController
      
      before_action :set_ticket

      def context_new
        @service = Core::Attendance::RecadastreService.new(ticket: @ticket)
        @service.create_context 4

        redirect_to recadastre_ticket_contact_path(ticket_id: @ticket.id, id: @ticket.cadastre_mirror_id)
      end

      def confirm
        @service = Core::Attendance::RecadastreService.new(ticket: @ticket)
        @service.confirm_by_context 4

        redirect_to recadastre_tickets_path
      end

      def show
      end

      def edit
        @cadastre_mirror = Core::Attendance::ContactForm.find(@ticket.cadastre_mirror_id)
      end

      def update
        @cadastre_mirror = Core::Attendance::ContactForm.find(@ticket.cadastre_mirror_id)
        
        if @cadastre_mirror.update(set_params)

          @service = Core::Attendance::RecadastreService.new(ticket: @ticket)
          @service.close_by_candidate 4
          
          redirect_to recadastre_tickets_path
        
        else
          render action: :edit
        end
      end

      private

      def set_params
        params.require(:attendance_contact_form).permit(:telephone, :telephone_optional, :celphone, :email, 
                                                        :address, :city_id, :state_id, :cep)
      end

      def set_ticket
        @ticket = current_cadastre.tickets.find(params[:ticket_id])
        @ticket = Core::Attendance::TicketPolicy.new(@ticket)
      end

    end
  end
end