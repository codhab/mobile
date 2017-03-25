
module Attendance
  class DependentsController < ApplicationController

    before_action :set_cadastre 
    before_action :set_ticket
    before_action :set_cadastre_mirror
    before_action :set_action
    before_action :set_dependent_mirror, only: [:edit, :update, :show]

    def index
      @cadastre_mirror = Core::Attendance::CadastreForm.find(@cadastre_mirror.id)
    end

    def show
      @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)
    end

    def new
    end

    def create
    end

    def edit
      @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)
    end

    def update
      @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)
      
      if @dependent_mirror.update(set_params)
        redirect_to ticket_continue_income_path(@ticket, @action)
      else
        render action: :edit
      end
    end

    private

    def set_params
      params.require(:attendance_dependent_form)
            .permit(:rg, :name, :cpf, :rg_org, :income, :born, :kinship_id, :special_condition_id)
    end

    def set_dependent_mirror
      @dependent_mirror = @cadastre_mirror.dependent_mirrors.find(params[:id])
    end

    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
      @ticket = Core::Attendance::TicketPolicy.new(@ticket)
    end

    def set_action
      @action = @ticket.actions.find_by(context_id: 2)
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_cadastre_mirror
      @cadastre_mirror = @cadastre.cadastre_mirrors.find(@ticket.cadastre_mirror_id)
    end
  end
end