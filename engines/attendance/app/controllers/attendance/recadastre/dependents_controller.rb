require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class DependentsController < ApplicationController
      
      before_action :set_ticket
      before_action :set_context
      before_action :set_cadastre_mirror, only: [:show, :edit, :update]

      def confirm
        @context.update(status: 'finalizado')
        
        redirect_to recadastre_ticket_contexts_path(@ticket)
      end

      def index
        @cadastre_mirror = @ticket.cadastre_mirror
      end

      def show
        @cadastre_mirror = @ticket.cadastre_mirror
      end

      def edit
        @dependent_mirror = @cadastre_mirror.dependent_mirrors.find(params[:id])
        @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)
      end

      def update
        @dependent_mirror = @cadastre_mirror.dependent_mirrors.find(params[:id])
        @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)

        if @dependent_mirror.update(set_params)
          redirect_to new_recadastre_ticket_context_document_path(ticket_id: @ticket, 
                                                                  context_id: @context, 
                                                                  dependent_mirror_id: @dependent_mirror) 
        else
          render action: :edit
        end
      end

      private

      def set_params
        params.require(:attendance_dependent_form).permit(:rg, :rg_org, :cpf, :name, :income, :born, 
                                                          :kinship_id, :special_condition_id)
      end

      def set_cadastre_mirror
        @cadastre_mirror = Core::Attendance::CadastreForm.find(@ticket.cadastre_mirror_id)
      end

      def set_context
        @context = Core::Attendance::TicketContextAction.find(params[:context_id])
      end

      def set_ticket
        @ticket = current_cadastre.tickets.find(params[:ticket_id])
        @ticket = Core::Attendance::TicketPolicy.new(@ticket)
        @ticket = Core::Attendance::TicketPresenter.new(@ticket)
      end
    end
  end
end