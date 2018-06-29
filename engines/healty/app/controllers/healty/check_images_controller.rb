require_dependency 'healty/application_controller'

module Healty
  class CheckImagensController < ApplicationController
    before_action :set_allotment
    before_action :set_unit

    def show
      @image = @unit.check_images.find(params[:id])
    end

    private

    def set_params
      params.require(:check_image).permit(:image)
    end

    def set_allotment
      @allotment = Healty::CheckAllotment.find(params[:allotment_id])
    end

    def set_unit
      @unit  = @allotment.units.find(params[:unit_id])
    end

  end
end
