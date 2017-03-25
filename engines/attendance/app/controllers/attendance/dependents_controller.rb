
module Attendance
  class DependentsController < ApplicationController

    before_action :set_cadastre 
    before_action :set_ticket
    before_action :set_cadastre_mirror
    before_action :set_action

    def index
      @cadatre_mirror = Core::Attendance::CadastreForm.find(@cadastre_mirror.id)
    end

    private

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
    end

    def set_action
      @action = @ticket.actions.find_by(context_id: 1)
    end

    def set_cadastre_mirror
      @cadastre_mirror = current_cadastre.cadastre_mirrors.find(@ticket.cadastre_mirror_id)
    end

  end
end