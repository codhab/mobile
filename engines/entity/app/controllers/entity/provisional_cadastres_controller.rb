require_dependency 'entity/application_controller'

module Entity
  class ProvisionalCadastresController < ApplicationController

    def new
      @enterprise = current_entity.enterprises.find(params[:enterprise_id])
      @provisional = Entity::ProvisionalCadastre.new
      @provisional.enterprise_id = @enterprise.id
    end
    
    def create
      @enterprise   = current_entity.enterprises.find(params[:enterprise_id])
      @provisional  = Entity::ProvisionalCadastre.new(set_params)
      @provisional.entity_id = current_entity.id 
      @provisional.enterprise_id = @enterprise.id
      
      if @provisional.save
        flash[:success] = t :success
        redirect_to indications_path
      else
        render action: :new
      end

    end


    private

    def set_params
      params.require(:provisional_cadastre).permit(:name, :cpf, :born)
    end

  end
end