require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class ContextsController < ApplicationController
      before_action :set_ticket

      def index
      end

      def new
        @context = @ticket.ticket_context_actions.find_by(ticket_context_id: params[:context_id]) rescue nil
        
        if @context.nil?
          @context = @ticket.ticket_context_actions.new.tap do |context|
            context.ticket_context_id = params[:context_id]
            context.status            = 0
          end
          
          @context.save
        end

        case params[:context_id].to_i 
        when 1 
          redirect_to recadastre_ticket_context_cadastre_path(@ticket, @context, @ticket.cadastre_mirror_id)
        when 2 
          redirect_to recadastre_ticket_context_dependents_path(@ticket, @context)
        when 3  
          redirect_to recadastre_ticket_context_income_path(@ticket, @context, @ticket.cadastre_mirror_id)
        when 4 
          redirect_to recadastre_ticket_context_contact_path(@ticket, @context, @ticket.cadastre_mirror_id)
        end 


      end

      private

      def set_ticket
        @ticket = current_cadastre.tickets.find(params[:ticket_id])
        @ticket = Core::Attendance::TicketPolicy.new(@ticket)
        @ticket = Core::Attendance::TicketPresenter.new(@ticket)
      end
    end
  end
end
