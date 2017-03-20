require_dependency 'core_attendance/handle_cadastre'

module Attendance
  class CadastresController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 

    def edit
      @cadastre_mirror = ::CoreAttendance::HandleCadastre.find(@ticket.cadastre_mirror_id)
    end

    def update
      @cadastre_mirror = ::CoreAttendance::HandleCadastre.find(@ticket.cadastre_mirror_id)
      
      if @cadastre_mirror.update(set_params)
        redirect_to edit_ticket_document_path(@ticket) 
      end
    end

    private

    def set_params
      params.require(:handle_cadastre)
            .permit(:rg, :gender, :born, :born_uf, :rg_org, 
                    :rg_uf, :place_birth, :cadastre_id, :nis, 
                    :cid, :adapted_property, :special_condition_id,
                    :special_condition_type_id, :mother_name)

    end

    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end