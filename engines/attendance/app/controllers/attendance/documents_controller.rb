require_dependency 'attendance/application_controller'

module Attendance
  class DocumentsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 
  
    def edit
      @service = CoreAttendance::TicketService.new.tap do |service|
                  service.ticket              = @ticket
                  service.context_id          = @ticket.ticket_context_id
                  service.cadastre            = @ticket.cadastre 
                  service.cadastre_mirror     = @ticket.cadastre_mirror
                  service.dependent_mirror_id = params[:dependent_mirror_id] 
                end

      @service.upload_required
      
      @ticket  = @service.ticket 
    end

    def update
      if @ticket.update(set_params)
        @ticket.update(ticket_status_id: 3)


        flash[:title]      = "Operação realizada com sucesso!"
        flash[:message]    = "Os seus dados foram atualizados com sucesso, veja o detalhamento abaixo"
        flash[:html_class] = "success"

        redirect_to ticket_path(@ticket)
      else
        @service = DocumentService.new(ticket: @ticket, cadastre: @cadastre, cadastre_mirror: @ticket.cadastre_mirror)
        @ticket = @service.ticket
        
        render action: :edit
      end
    end

    private

    def set_params
      params.fetch(:ticket, {})
            .permit(
                    rg_uploads_attributes: [:upload_path, :_destroy, :id],
                    cpf_uploads_attributes: [:upload_path, :_destroy, :id],
                    residence_uploads_attributes: [:upload_path, :_destroy, :id],
                    arrival_df_uploads_attributes: [:upload_path, :_destroy, :id],
                    registry_uploads_attributes: [:upload_path, :_destroy, :id],
                    certificate_born_uploads_attributes: [:upload_path, :_destroy, :id],
                    income_uploads_attributes: [:upload_path, :_destroy, :id],
                    special_condition_uploads: [:upload_path, :_destroy, :id]
                    )
    end
    
    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end