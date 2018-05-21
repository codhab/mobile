require_dependency 'healty/application_controller'

module Healty
  class CheckUnitsController < ApplicationController
    before_action :set_allotment

    def index
      @units = @allotment.units
    end

    private

    def set_allotment
      @allotment = Healty::CheckAllotment.find(params[:allotment_id])
    end

  end
end
