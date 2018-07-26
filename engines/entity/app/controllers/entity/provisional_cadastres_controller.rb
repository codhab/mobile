require_dependency 'entity/application_controller'

module Entity
  class ProvisionalCadastresController < ApplicationController

    def new
      @provisional = Entity::ProvisionalCadastre.new
    end
    
    def create
      @provisional  = Entity::ProvisionalCadastre.new(set_params)
      @provisional.entity_id = current_entity.id 
      
      if @provisional.save
        flash[:success] = t :success
        redirect_to indications_path
      else
        render action: :new
      end

    end


    private

    def set_params
      params.require(:provisional_cadastre).permit(:name, :cpf, :born, :enterprise_id)
    end

  end
end