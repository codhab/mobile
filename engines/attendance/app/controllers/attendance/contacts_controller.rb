
module Attendance
  class ContactsController < ApplicationController

    before_action :set_cadastre 
    before_action :set_ticket
    before_action :set_action

    def edit
      @cadastre_mirror = Core::Attendance::ContactForm.find(@cadastre.id)
    end

    private

    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
      @ticket = Core::Attendance::TicketPolicy.new(@ticket)
    end

    def set_action
      @action = @ticket.actions.find_by(context_id: 1)
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end