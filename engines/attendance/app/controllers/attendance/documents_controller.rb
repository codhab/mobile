
module Attendance
  class DocumentsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 
  
    def edit
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
            .permit(rg_uploads_attributes: [:upload_path, :_destroy, :id])
    end
    
    def set_ticket
      @ticket = @cadastre.attendance_tickets.find_by_cadastre_id(@cadastre.id)
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end