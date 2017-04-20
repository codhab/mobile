require_dependency 'entity/application_controller'

module Entity
  class ContactsController < ApplicationController
    
    def edit
      @entity = current_entity
    end

    def update
      @entity = current_entity

      if @entity.update(set_params)
        flash[:success] = "Dados atualizados com sucesso!"
        redirect_to action: :edit
      else
        render action: :edit
      end

    end

    private

    def set_params
      params
    end

  end
end