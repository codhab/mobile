module Attendance
  class DependentsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 
    
    def index
      @cadastre_mirror = @ticket.cadastre_mirror
    end

    def new
    end

    def create
    end
    
    def edit
      @dependent_mirror = @ticket.cadastre_mirror.dependent_mirrors.find(params[:dependent_id])
      @dependent_mirror = Attendance::HandleDependent::DependentMirrorModel.find(@dependent_mirror.id)

    end

    def update
      @dependent_mirror = @ticket.cadastre_mirror.dependent_mirrors.find(params[:dependent_id])
      @dependent_mirror = Attendance::HandleDependent::DependentMirrorModel.find(@ticket.id)
      
      redirect_to edit_document_path(@ticket) if @dependent_mirror.update(set_params)
    end

    private

    def set_ticket
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end


    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end