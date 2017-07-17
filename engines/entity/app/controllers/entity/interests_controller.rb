require_dependency 'entity/application_controller'

module Entity
  class InterestsController < ApplicationController
    before_action :set_address

    def index

    end

    def update
      @interest = current_entity.interests.find_by(unit_sale_id: params[:interest_id])  rescue nil

      if @interest.present?
        @interest.destroy
      else
        @interest = current_entity.interests.new(unit_sale_id: params[:interest_id])
        @interest.save
      end
    end

    private

    def set_address
      @address = Core::Entity::UnitSale.all
      @interests = current_entity.interests
    end
  end
end
