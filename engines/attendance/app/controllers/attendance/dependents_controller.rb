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
      @dependent_mirror.cadastre_mirror_id = @cadastre_mirror.id

      if @dependent_mirror.save
        redirect_to edit_document_path(ticket_id: @ticket, dependent_mirror_id: @dependent_mirror.id)
      end
    end
    
    def edit
      @dependent_mirror = @ticket.cadastre_mirror.dependent_mirrors.find(params[:dependent_id])
      @dependent_mirror = Attendance::HandleDependent::DependentMirrorModel.find(@dependent_mirror.id)
    end

    def update
      @dependent_mirror = @ticket.cadastre_mirror.dependent_mirrors.find(params[:dependent_id])
      @dependent_mirror = Attendance::HandleDependent::DependentMirrorModel.find(@ticket.id)
      
      if @dependent_mirror.update(set_params)
        redirect_to edit_document_path(ticket_id: @ticket.id, dependent_mirror_id: params[:dependent_id])
      end
    end

    def remove
      @dependent_mirror = @ticket.cadastre_mirror.dependent_mirrors.find(params[:dependent_id])
    end

    def destroy
      @dependent_mirror = @ticket.cadastre_mirror.dependent_mirrors.find(params[:dependent_id])
      @dependent_mirror.destroy

      redirect_to dependents_path(@ticket)
    end

    private

    def set_params
      params.require(:handle_dependent_dependent_mirror_model).permit(:place_birth, :name, :cpf, :rg, :rg_org,:rg_uf_id,:born,:gender,
                                                                      :civil_state_id,:income,:kinship_id,:co_acquirer,:percentage,
                                                                      :special_condition_id,:cid,:nis, :name,:cpf,:rg,:rg_org,:rg_uf_id,
                                                                      :born,:gender,:civil_state_id,:income,:kinship_id,:co_acquirer,
                                                                      :percentage,:special_condition_id,:cid,:nis)
    end

    def set_ticket
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end


    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end