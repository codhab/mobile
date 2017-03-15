
module Attendance
  class CadastresController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 

    def edit
      @cadastre_mirror = Attendance::HandleCadastre::CadastreMirrorModel.find(@ticket.cadastre_mirror_id)
    end

    def update
      @cadastre_mirror = Attendance::HandleCadastre::CadastreMirrorModel.find(@ticket.cadastre_mirror_id)
      redirect_to edit_document_path(@ticket) if @cadastre_mirror.update(set_params)
    end

    private

    def set_params
      params.require(:handle_cadastre_cadastre_mirror_model)
            .permit(:rg, :gender, :born, :born_uf, :rg_org, 
                    :rg_uf, :place_birth, :cadastre_id, :nis, 
                    :cid, :adapted_property, :special_condition_id, :special_condition_type_id)

    end

    def set_ticket
      @ticket = @cadastre.attendance_tickets.find_by_cadastre_id(@cadastre.id)
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end