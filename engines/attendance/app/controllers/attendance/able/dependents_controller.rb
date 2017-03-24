require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/able_service'

module Attendance
  module Able
    class DependentsController < ApplicationController
      
      before_action :set_ticket
      before_action :set_context
      before_action :set_cadastre_mirror, only: [:index, :show, :edit, :update]
        
      def index
      end

      def edit 
      end

      def update
        if @cadastre_mirror.update(set_params)
          redirect_to new_able_ticket_context_document_path(@ticket, @context)
        else
          render action: :edit
        end
      end


      private

      def set_params
        params.require(:attendance_cadastre_form).permit(:rg)
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