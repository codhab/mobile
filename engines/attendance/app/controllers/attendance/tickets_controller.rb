require_dependency 'attendance/ticket_presenter'
require_dependency 'attendance/ticket_service'

module Attendance
  class TicketsController < ApplicationController
    before_action :set_cadastre

    def index
      @tickets = @cadastre.attendance_tickets
    end

    def new
      @ticket          = Attendance::TicketPresenter.new(@cadastre, view_context)
      @ticket_service  = Attendance::TicketService.new(cadastre: @cadastre)
    end

    def show
      @ticket = @cadastre.attendance_tickets.find(params[:id])
    end

    def pre_create
      @context = params[:context_id] ||= 1
    end

    def pre_finish
      @ticket = @cadastre.attendance_tickets.find(params[:id])
    end

    def create
      @service = TicketService.new(cadastre: @cadastre, context_id: params[:context_id])

      if @service.create
        redirect_to @service.route_path
      else
        redirect_to new_ticket_path
      end
    end

    def continue
      @ticket  = @cadastre.attendance_tickets.find(params[:ticket_id])
      @service = TicketService.new(cadastre: @cadastre, ticket: @ticket, context_id: @ticket.ticket_context_id)
      redirect_to @service.route_path
    end

    def cancel
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end
    
    def close
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
      @ticket.update(ticket_status_id: 7)
      
      redirect_to :back 
    end

    private

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_ticket
    end

  end
end