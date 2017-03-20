require_dependency 'core_attendance/ticket'
require_dependency 'core_attendance/ticket_presenter'

module Attendance
  class TicketsController < ApplicationController
    before_action :set_cadastre

    def index
      @tickets = current_cadastre.tickets
    end

    def show
      @ticket = @cadastre.tickets.find(params[:id])
      @ticket = CoreAttendance::TicketPresenter.new(@ticket, view_context)
      @ticket = CoreAttendance::TicketPolicy.new(@ticket)

      @ticket.ticket_comments.update_all(read: true)
    end

    # routes to :cancel ticket
    def pre_delete
      @ticket = @cadastre.tickets.find(params[:ticket_id])
    end

    def delete
      @ticket = @cadastre.tickets.find(params[:ticket_id])
      @ticket.update(ticket_status_id: 7, status: false)

      redirect_to new_context_path
    end


    private

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_ticket
    end

  end
end