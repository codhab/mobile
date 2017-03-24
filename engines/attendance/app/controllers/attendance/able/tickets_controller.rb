require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/able_service'

module Attendance
  module Able
    class TicketsController < ApplicationController
      
      def index
        @service = Core::Attendance::AbleService.new(cadastre: current_cadastre)

        @context_cadastre  = @service.able_situation_by_context(1)
        @context_dependent = @service.able_situation_by_context(2)
        @context_income    = @service.able_situation_by_context(3)
        @context_contact   = @service.able_situation_by_context(4)
      end

      def new
        @service = Core::Attendance::AbleService.new(cadastre: current_cadastre, context_id: params[:context_id].to_i)
        @service.create_ticket if !@service.ticket
        
        
        case @service.context.ticket_context_id
        when 1
          redirect_to edit_able_ticket_context_cadastre_path(@service.ticket.id, @service.context.id, @service.cadastre_mirror.id)
        when 2
          redirect_to able_ticket_context_dependents_path(@service.ticket.id, @service.context.id)
        when 3
          redirect_to edit_able_ticket_context_income_path(@service.ticket.id, @service.context.id)
        when 4
          redirect_to edit_able_ticket_context_contact_path(@service.ticket.id, @service.context.id)
        end

      end

      
      private

      def set_ticket
      end

    end
  end
end