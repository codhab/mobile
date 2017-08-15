require_dependency 'entity/application_controller'

module Entity
  class InterestsController < ApplicationController
    before_action :set_address, only: [:new, :create]

    def index
    end

    def new
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id).new
    end

    def create
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id).new(set_params)

      if @interest.save 
        redirect_to entity_interest_path(@interest)
      else 
        flash[:error] = t :error
        render action: :new
      end

    end

    def show
      @interest = current_entity.interests.find(params[:id])
    end


    private

    def set_params
      params.fetch(:entity_interest_form, {}).permit(unit_sale_ids: [])
    end


    def set_address
      @addresses = Core::Entity::UnitSale.where(status: true)
    end

  end
end
