
module Attendance
  class CadastresController < ApplicationController

    before_action :set_cadastre 
    before_action :set_ticket
    before_action :set_cadastre_mirror
    before_action :set_action

    def edit
      @cadastre_mirror = Core::Attendance::CadastreForm.find(@cadastre_mirror.id)
    end

    def update
      @cadastre_mirror = Core::Attendance::CadastreForm.find(@cadastre_mirror.id)
      
      if @cadastre_mirror.update(set_params)
        redirect_to ticket_continue_cadastre_path(@ticket, @action)
      else
        render action: :edit
      end
    end

    private

    def set_params
      params.require(:attendance_cadastre_form)
            .permit(:rg, :rg_org)
    end

    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
      @ticket = Core::Attendance::TicketPolicy.new(@ticket)
    end

    def set_action
      @action = @ticket.actions.find_by(context_id: 1)
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_cadastre_mirror
      @cadastre_mirror = @cadastre.cadastre_mirrors.find(@ticket.cadastre_mirror_id)
    end

  end
end