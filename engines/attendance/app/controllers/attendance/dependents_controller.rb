module Attendance
  class DependentsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 
    
    def index
      @cadastre_mirror = @ticket.cadastre_mirror
    end

    def new
      @cadastre_mirror  = @ticket.cadastre_mirror
      @dependent_mirror = Attendance::HandleDependent::DependentMirrorModel.new
      @dependent_mirror.cadastre_id = @cadastre_mirror.id
    end

    def create
      @cadastre_mirror  = @ticket.cadastre_mirror
      @dependent_mirror = Attendance::HandleDependent::DependentMirrorModel.new(set_params)
      @dependent_mirror.cadastre_id = @cadastre_mirror.id

      redirect_to edit_document_path(@ticket) if @dependent_mirror.update(set_params)
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

    def set_params
      params.require(:handle_dependent_dependent_mirror_model).permit(:place_birth, :name, :cpf, rg, rg_org, rg_uf_id, born, gender, civil_state_id, income, kinship_id, co_acquirer, percentage, special_condition_id, cid, nis
Unpermitted parameters: name, cpf, rg, rg_org, rg_uf_id, born, gender, civil_state_id, income, kinship_id, co_acquirer, percentage, special_condition_id, cid, nis)
    end

    def set_ticket
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end


    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end