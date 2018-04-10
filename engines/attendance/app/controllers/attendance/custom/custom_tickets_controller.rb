require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomTicketsController < Attendance::Custom::CustomApplicationController
      before_action :set_ticket, only: [:cadastre, :dependent, :income, :contact, :document]
      def index
        @ticket = Attendance::CustomTicket.find_by(cadastre_id: current_cadastre.id) rescue nil

        if @ticket.request && @ticket.requests.where(closed: true, candidate_read: false).present?
          @ticket.requests.where(closed: true).update_all(candidate_read: true, candidate_read_at: Time.now)
        end
      end

      def new
        @ticket = Attendance::CustomTicket.new(cadastre_id: current_cadastre.id)
        @ticket.save
      end

      def cadastre
        @ticket.update(action_one: true)
        redirect_to attendance.custom_custom_tickets_path

        update_ticket
      end

      def dependent
        @ticket.update(action_two: true)
        redirect_to attendance.custom_custom_tickets_path

        update_ticket
      end

      def income
        @ticket.update(action_three: true)
        redirect_to attendance.custom_custom_tickets_path

        update_ticket
      end

      def contact
        @ticket.update(action_four: true)
        redirect_to attendance.custom_custom_tickets_path

        update_ticket

      end

      def document
        @ticket.update(action_five: true)
        redirect_to attendance.custom_custom_tickets_path

        update_ticket
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


      def message
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])

        respond_to do |format|
          format.html {
            if params[:reboot].present?
              case params[:step]
              when 'cadastre'
                @ticket.update(action_one: false)
              when 'dependent'
                @ticket.update(action_two: false)
              when 'income'
                @ticket.update(action_three: false)
              when 'contact'
                @ticket.update(action_four: false)
              when 'document'
                @ticket.update(action_five: false)
              end

              redirect_to custom_custom_tickets_path
            end
          }

          format.js {}
        end
      end

      private

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def update_ticket
        if @ticket.finalized? && @ticket.request
          @ticket.update(request: false)
          @ticket.requests.update_all(closed: true, closed_at: Time.now)
        end
      end
    end
  end
end
