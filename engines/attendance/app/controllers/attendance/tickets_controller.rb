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

    def close 
      @ticket = @cadastre.tickets.find(params[:ticket_id])
        
      @ticket.update(ticket_status_id: 3)

      flash[:title]      = "Operação realizada com sucesso!"
      flash[:message]    = "Os seus dados foram atualizados com sucesso, veja o detalhamento abaixo"
      flash[:html_class] = "success"
      
      redirect_to ticket_path @ticket
    end

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