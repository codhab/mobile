require_dependency 'core/attendance/ticket_service'

module Attendance
  class TicketsController < ApplicationController
    before_action :set_ticket, only: [:close, :confirm]

    def index
      @tickets = current_candidate.tickets.order('created_at DESC')
    end

    def show
      @ticket = current_candidate.tickets.find(params[:id])
    end

    def new
      @service = Core::Attendance::TicketService.new.tap do |service|
        service.cadastre = current_candidate
      end
      
      @service.create_or_find
      
      @ticket = @service.ticket
    end

    def confirm
      @service = Core::Attendance::TicketService.new.tap do |service|
        service.cadastre = current_candidate
        service.ticket   = @ticket
      end

      @service.confirm
    end

    def close
      @service = Core::Attendance::TicketService.new.tap do |service|
        service.cadastre = current_candidate
        service.ticket   = @ticket
      end

      @service.close      
    end

    private

    def set_ticket
      @ticket = Core::Attendance::Ticket.find(params[:ticket_id])
    end

  end
end
