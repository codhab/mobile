require_dependency 'attendance/application_controller'

module Attendance
  class IncomesController < ApplicationController
    
    before_action :set_cadastre 
    before_action :set_ticket
    
    def edit
      @cadastre_mirror = @ticket.cadastre_mirror
    end

    def update
      @cadastre_mirror = @ticket.cadastre_mirror
      redirect_to edit_document_path @ticket if @cadastre_mirror.update(set_params)
    end


    private

    def set_params
      params.require(:candidate_cadastre_mirror).permit(:main_income,
                                                        income_dependet_mirrors_attributes: [:income, :id])
    end


    def set_ticket
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end


    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end