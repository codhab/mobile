
module Attendance
  class DependentsController < ApplicationController

    before_action :set_cadastre 
    before_action :set_ticket
    before_action :set_cadastre_mirror
    before_action :set_action
    before_action :set_dependent_mirror, only: [:edit, :update, :show, :destroy]

    def index
      @cadastre_mirror = Core::Attendance::CadastreForm.find(@cadastre_mirror.id)
    end

    def show
      @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)
    end

    def new
      @dependent_mirror = Core::Attendance::DependentForm.new
    end

    def create
      @dependent_mirror = Core::Attendance::DependentForm.new(set_params)
      
      if @dependent_mirror.valid?
        @new_dependent_mirror = @cadastre_mirror.dependent_mirrors.new(@dependent_mirror.attributes)
        @new_dependent_mirror.save
          
        redirect_to ticket_continue_dependent_path(@ticket, @action, dependent_id: @new_dependent_mirror.id)
      else
        render action: :new
      end
    end

    def edit
      @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)
    end

    def update
      @dependent_mirror = Core::Attendance::DependentForm.find(@dependent_mirror.id)
      
      if @dependent_mirror.update(set_params)
        redirect_to ticket_continue_dependent_path(@ticket, @action, dependent_id: @dependent_mirror.id)
      else
        render action: :edit
      end
    end

    def destroy
      @dependent_mirror.destroy

      redirect_to ticket_dependents_path(@ticket)
    end

    private

    def set_params
      params.require(:attendance_dependent_form)
            .permit(:rg, :name, :cpf, :rg_org, 
                    :income, :born, :kinship_id, 
                    :special_condition_id, :cid,
                    :special_condition_type_id)
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