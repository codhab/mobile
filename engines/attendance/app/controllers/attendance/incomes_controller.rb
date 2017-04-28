module Attendance
  class IncomesController < ApplicationController
    before_action :set_cadastre
    before_action :set_ticket
    before_action :set_cadastre_mirror
    before_action :set_action

    def index; end

    def edit
      @dependent = params[:dependent]

      if @dependent.present?
        @mirror = Core::Attendance::IncomeDependentForm.find(params[:id]) rescue nil
      else
        @mirror = Core::Attendance::IncomeForm.find(params[:id]) rescue nil
      end
    end


    def update
      @dependent_params = params[:dependent]

      if @dependent_params.present?
        @dependent_mirror = Core::Attendance::IncomeDependentForm.find(params[:id]) rescue nil

        if @dependent_mirror.update(set_dependent_params)
          session[:dependent_id] = @dependent_mirror.id if !@dependent_mirror.nil?
          redirect_to ticket_continue_income_path(@ticket, @action, dependent_id: @dependent_mirror.id)
        else
          render action: :edit
        end
      else
        @cadastre_mirror = Core::Attendance::IncomeForm.find(params[:id]) rescue nil

        if @cadastre_mirror.update(set_params)
          redirect_to ticket_continue_income_path(@ticket, @action)
        else
          render action: :edit
        end
      end

    end

    private

    def set_params
      params.require(:attendance_income_form).permit(:main_income, :income)
    end

    def set_dependent_params
      params.require(:attendance_income_dependent_form).permit(:income)
    end

    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
      @ticket = Core::Attendance::TicketPolicy.new(@ticket)
    end

    def set_action
      @action = @ticket.actions.find_by(context_id: 3)
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_cadastre_mirror
      @cadastre_mirror = @cadastre.cadastre_mirrors.find(@ticket.cadastre_mirror_id)
    end

  end
end
