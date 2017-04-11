require_dependency 'core/attendance/ticket_service'

module Attendance
  class TicketsController < ApplicationController
    before_action :set_ticket, except: [:index, :show, :new]
    before_action :set_action, only:   [:confirm, :open, 
                                        :continue_cadastre, :continue_dependent,
                                        :continue_income,  :continue_contact,
                                        :close_action, :close_dependent]

    before_action :allow_action?, only: [:update_cadastre, :update_dependent, :update_income, :update_contact]

    def index
      @tickets = current_cadastre.tickets.order('created_at DESC')
    end

    def show
      @ticket = current_cadastre.tickets.find(params[:id]).presenter
    end

    def new
      @ticket_service = Core::Attendance::TicketService.new(cadastre: current_cadastre)
      @ticket_service.create_or_find(params[:context_id].to_i)

      @ticket = Core::Attendance::TicketPresenter.new(@ticket_service.ticket)
      @ticket = Core::Attendance::TicketPolicy.new(@ticket)
    end

    def confirm
      @service = Core::Attendance::TicketService.new(cadastre: current_cadastre, ticket: @ticket, action: @action)
      @service.confirm_action

      redirect_to new_ticket_path
    end

    def open
      @service = Core::Attendance::TicketService.new(ticket: @ticket, action: @action)
      @service.open_action

      redirect_to :back
    end

    def close
      @service = Core::Attendance::TicketService.new(cadastre: current_cadastre, ticket: @ticket)
      @service.close_ticket

      flash[:green] = "Operação realizada com sucesso!"
      
      redirect_to main_app.root_path
    end

    def close_dependent
      redirect_to new_ticket_action_document_path(ticket_id: @ticket, action_id: @action, dependent_all: true)
    end

    def close_action 
      @service = Core::Attendance::TicketService.new(cadastre: current_cadastre, ticket: @ticket, action: @action)
      @service.close_action
      redirect_to new_ticket_path
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
      
      redirect_to ticket_incomes_path(@ticket, @ticket.cadastre_mirror) 
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
      redirect_to new_ticket_action_document_path(ticket_id: @ticket, action_id: @action, dependent_id: params[:dependent_id])
    end

    def continue_income
      redirect_to new_ticket_action_document_path(@ticket, @action)
    end

    def continue_contact
      @service = Core::Attendance::TicketService.new(ticket: @ticket, action: @action)
      @service.close_action

      redirect_to new_ticket_path
    end

    private

    def allow_action?
      redirect_to new_ticket_path if ![1,2].include?(@ticket.situation_id) 
    end

    def set_ticket
      @ticket = current_cadastre.tickets.find(params[:ticket_id])
    end

    def set_action
      @action = @ticket.actions.find(params[:action_id])
    end

  end
end
