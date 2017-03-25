require_dependency 'attendance/application_controller'

module Attendance
  class DocumentsController < ApplicationController
      
    before_action :set_cadastre
    before_action :set_ticket
    before_action :set_action 

    def new      
      @action = Core::Attendance::ActionDocumentForm.find(@action.id)
    end

    def create
    end

    private

    def set_params
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_ticket
      @ticket   = @cadastre.tickets.find(params[:ticket_id]) 
    end

    def set_action
      @action   = @ticket.actions.find(params[:action_id])
    end
  end
end