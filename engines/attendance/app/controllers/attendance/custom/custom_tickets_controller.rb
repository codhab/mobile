require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomTicketsController < Attendance::Custom::CustomApplicationController
      before_action :set_ticket, only: [:cadastre, :dependent, :income, :contact, :document]
      def index
        @ticket = Attendance::CustomTicket.find_by(cadastre_id: current_cadastre.id) rescue nil
      end

      def new
        @ticket = Attendance::CustomTicket.new(cadastre_id: current_cadastre.id)
        @ticket.save
      end

      def cadastre
        @ticket.update(action_one: true)
        redirect_to attendance.custom_custom_tickets_path
      end

      def dependent
        @ticket.update(action_two: true)
        redirect_to attendance.custom_custom_tickets_path
      end

      def income
        @ticket.update(action_three: true)
        redirect_to attendance.custom_custom_tickets_path
      end

      def contact
        @ticket.update(action_four: true)
        redirect_to attendance.custom_custom_tickets_path
      end

      def document
        @ticket.update(action_five: true)
        redirect_to attendance.custom_custom_tickets_path
      end

      # Termos

      def term_one
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
        @ticket.update(term_one: true)
        redirect_to custom_custom_tickets_path
      end

      def term_two
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
        @ticket.update(term_two: true)
        redirect_to custom_custom_tickets_path
      end

      def term_three
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
        @ticket.update(term_three: true)
        redirect_to custom_custom_tickets_path
      end

      private

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end
    end
  end
end
