module Attendance
  class IndicationsController < ApplicationController
    before_action :set_indication

    def index
      @indications = current_cadastre.enterprise_cadastres
    end

    def edit      
    end

    def update
      @service = Core::Attendance::IndicationService.new(current_cadastre)

      if @service.accepted_indication(@indication)
        flash[:success] = "Indicação atualizada com sucesso!"
        redirect_to action: :index
      else
        flash[:info]    = "Nâo é possível atualizar com sucesso!"
        render action: :edit
      end
    end

    private

    def set_indication
      @indication = current_cadastre.enterprise_cadastres.find(params[:id])
    end

  end
end