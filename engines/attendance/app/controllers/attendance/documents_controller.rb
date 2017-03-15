require_dependency 'attendance/application_controller'

module Attendance
  class DocumentsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 
  
    def edit
      @service = DocumentService.new(ticket: @ticket, 
                                     cadastre: @cadastre, 
                                     cadastre_mirror: @ticket.cadastre_mirror, 
                                     context_id: @ticket.ticket_context_id, 
                                     dependent_mirror_id: params[:dependent_mirror_id])
      
      @ticket  = @service.document_required
    end

    def update
      if @ticket.update(set_params)
        redirect_to pre_finish_tickets_path(@ticket)
      else
        @service = DocumentService.new(ticket: @ticket, cadastre: @cadastre, cadastre_mirror: @ticket.cadastre_mirror)
        @ticket = @service.ticket
        
        render action: :edit
      end
    end

    private

    def set_params
      params.fetch(:attendance_ticket, {})
            .permit(
                    rg_uploads_attributes: [:upload_path, :_destroy, :id],
                    cpf_uploads_attributes: [:upload_path, :_destroy, :id],
                    residence_uploads_attributes: [:upload_path, :_destroy, :id],
                    arrival_df_uploads_attributes: [:upload_path, :_destroy, :id],
                    registry_uploads_attributes: [:upload_path, :_destroy, :id],
                    certificate_born_uploads_attributes: [:upload_path, :_destroy, :id]
                    )
    end
    
    def set_ticket
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end