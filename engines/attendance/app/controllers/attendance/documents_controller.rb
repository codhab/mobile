
module Attendance
  class DocumentsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 
  
    def edit
      @service = DocumentService.new(ticket: @ticket, cadastre: @cadastre, cadastre_mirror: @ticket.cadastre_mirror)
      @service.document_required

      @ticket = @service.ticket
    end

    def update
      if @ticket.update(set_params)
      
      else
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
                    )
    end
    
    def set_ticket
      @ticket = @cadastre.attendance_tickets.find_by_cadastre_id(@cadastre.id)
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end