module Entity
  class IndicationsController < ApplicationController
    
    def index
      @units = Core::Entity::IndicationUnit.where(entity_id: current_entity.id)
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    private

    def set_params
    end

  end
end