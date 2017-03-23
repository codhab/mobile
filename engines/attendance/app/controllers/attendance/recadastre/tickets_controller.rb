require_dependency 'attendance/application_controller'
require_dependency 'core/attendance/recadastre_service'

module Attendance
  module Recadastre
    class TicketsController < ApplicationController
      before_action :set_ticket, only: :confirm
      
      def new
        @service = Core::Attendance::RecadastreService.new(cadastre: current_cadastre)

        if @service.ticket.present?
          redirect_to recadastre_ticket_contexts_path(@service.ticket)
        else
          @service.create
          redirect_to recadastre_ticket_contexts_path(@service.ticket)
        end
      end

      def confirm
        @service = Core::Attendance::RecadastreService.new(cadastre: current_cadastre, ticket: @ticket)
        @service.close_recadastre

        @notification = Core::NotificationService.new
        @notification.create({
            cadastre_id: current_cadastre.id, 
            title: "Recadastramento realizado com sucesso!",
            content: "Seu recadastramento foi realizado com sucesso, para visualizar mais detalhes entre no menu 'Minhas atualizações'",
            push: true
        })

        redirect_to main_app.root_path
      end

      private

      def set_ticket
        @ticket = current_cadastre.tickets.find(params[:ticket_id])
        @ticket = Core::Attendance::TicketPolicy.new(@ticket)
        @ticket = Core::Attendance::TicketPresenter.new(@ticket)
      end

    end
  end
end