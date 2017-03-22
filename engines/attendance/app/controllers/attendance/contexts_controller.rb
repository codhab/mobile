require_dependency 'attendance/application_controller'

module Attendance
  class ContextsController < ApplicationController
    
    def new
      @context = Core::Attendance::ContextPresenter.new(current_cadastre, view_context)
    end

    def pre_create
      @context_id = params[:context_id]
    end

    def create
      @service = Core::Attendance::TicketService.new.tap do |service|
        service.cadastre    = current_cadastre
        service.context_id  = params[:context_id]
      end

      if @service.create
        redirect_to ticket_path(@service.ticket.id)
      else
        flash[:danger] = t(:danger)
        redirect_to action: :new
      end
    end

  end
end

