require_dependency 'entity/application_controller'

module Entity
  class IndicationsController < ApplicationController
    before_action :set_units

    def index
      @enterprises = current_entity.enterprises
    end

    def new
      if params[:enterprise_id].present?
        session[:enterprise_id] = params[:enterprise_id]
      end

      @enterprise = current_entity.enterprises.find(session[:enterprise_id])
      @indication = Core::Entity::Indication.new(enterprise_id: @enterprise.id)
    end

    def create
      @enterprise = current_entity.enterprises.find(session[:enterprise_id])
      @indication = Core::Entity::Indication.new(set_params)

      @indication.enterprise_id = @enterprise.id

      if @indication.valid?
        @indication.persist_indication

        redirect_to new_indication_path
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
      params.require(:entity_indication).permit(:cpf, :enterprise_id)
    end

    def set_units
      @units = Core::Entity::IndicationUnit.where(entity_id: current_entity.id)
    end
  end
end
