require_dependency 'attendance/application_presenter'

module Attendance
  class TicketPresenter < ApplicationPresenter

    def current_ticket_by_context context
      current_ticket context
    end
    
    def cadastre_update_status
      ticket_by_context(1)
    end

    def dependent_update_status
      ticket_by_context(2)
    end

    def income_update_status
      ticket_by_context(3)
    end

    def contact_update_status
      ticket_by_context(4)
    end

    private

    def ticket_by_context context
      ticket = self.attendance_tickets.where(ticket_context_id: context).order("created_at ASC").last
      if ticket.present?
        if [2,5,6,7].include? ticket.ticket_status_id
          "Toque para iniciar a atualização"
        else
          ticket.ticket_status.name
        end 
      else
        "Toque para iniciar a atualização"
      end
    end

    def current_ticket context
      self.attendance_tickets.where(ticket_context_id: context).order("created_at ASC").last
    end
  end 
end