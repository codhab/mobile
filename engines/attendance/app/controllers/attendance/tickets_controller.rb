require_dependency 'core/attendance/ticket_service'

module Attendance
  class TicketsController < ApplicationController
    before_action :set_ticket, except: [:index, :show, :new]
    before_action :set_action, only:   [:confirm, :open, :close, :continue_cadastre]

    def index
      @tickets = current_candidate.tickets.order('created_at DESC')
    end

    def show
      @ticket = current_candidate.tickets.find(params[:id])
    end

    def new
      @ticket_service = Core::Attendance::TicketService.new(cadastre: current_cadastre)
      @ticket_service.create_or_find(params[:context_id].to_i)

      @ticket = Core::Attendance::TicketPresenter.new(@ticket_service.ticket)
    end

    def confirm
      @service = Core::Attendance::TicketService.new.tap do |service|
        service.cadastre = current_candidate
        service.ticket   = @ticket
      end

      @service.confirm
    end

    def open
      @service = Core::Attendance::TicketService.new(ticket: @ticket, action: @action)
      @service.open_action

      redirect_to :back
    end

    def close
      @service = Core::Attendance::TicketService.new.tap do |service|
        service.cadastre = current_candidate
        service.ticket   = @ticket
      end

      @service.close      
    end

    def update_cadastre
      @service = Core::Attendance::TicketService.new(ticket: @ticket)
      @service.create_or_find_action 1

      @action = @service.action

      redirect_to edit_ticket_cadastre_path(@ticket, @ticket.cadastre_mirror)
    end

    def update_dependent
      @service = Core::Attendance::TicketService.new(ticket: @ticket)
      @service.create_or_find_action 2

      @action = @service.action

      redirect_to ticket_dependents_path(@ticket)
    end

    def update_income
      @service = Core::Attendance::TicketService.new(ticket: @ticket)
      @service.create_or_find_action 3

      @action = @service.action

      redirect_to edit_ticket_income_path(@ticket, @ticket.cadastre_mirror)
    end

    def update_contact
      @service = Core::Attendance::TicketService.new(ticket: @ticket)
      @service.create_or_find_action 4

      @action = @service.action

      redirect_to edit_ticket_contact_path(@ticket, @ticket.cadastre_mirror)
    end

    def continue_cadastre
      redirect_to new_ticket_action_document_path(@ticket, @action)
    end

    def continue_dependent
    end

    def continue_income
    end

    def continue_contact
    end

    private

    def set_ticket
      @ticket = current_cadastre.tickets.find(params[:ticket_id])
    end

    def set_action
      @action = @ticket.actions.find(params[:action_id])
    end

  end
end
