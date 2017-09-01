require_dependency 'social/application_controller'

module Social
  class IndicationsController < ApplicationController
    before_action :set_units

    def index
    end

    def new
      @unit       = @units.find(params[:indication_id])
      @indication = Core::Social::Indication.new(indication_id: @unit.id)
    end

    def create
      @unit       = @units.find(params[:indication_id])
      @indication = Core::Social::Indication.new(set_params)

      @indication.indication_id = @unit.id

      if @indication.valid?
        @indication.persist_indication

        redirect_to new_indication_path(indication_id: @unit.id)
      else
        render action: :new
      end
    end

    def confirm
      @unit = @units.find(params[:indication_id])
      if @unit.update(situation: 'candidato_indicado')
        @unit.indicate_candidate!
      end

      redirect_to new_indication_path(indication_id: @unit.id)
    end

    def cancel
      @unit = @units.find(params[:indication_id])
      @unit.update(cadastre_id: nil, situation: 'indicado_para_entidade')

      @unit.indication_logs.create({
        cadastre_id: @unit.cadastre_id,
        description: "Candidato removido."
      })

      redirect_to new_indication_path(indication_id: @unit.id)
    end

    def edit
    end

    def update
    end

    private

    def set_params
      params.require(:social_indication).permit(:cpf)
    end

    def set_units
      @units = Core::Social::IndicationUnit.where(social_id: current_social.id)
    end

  end
end
