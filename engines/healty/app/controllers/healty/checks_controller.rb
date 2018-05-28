require_dependency 'healty/application_controller'

module Healty
  class ChecksController < ApplicationController
    before_action :set_allotment
    before_action :set_unit

    def index
    end

    def new
      @check = @unit.checks.new
    end

    def create
      @check = @unit.checks.new(set_params)

      if @check.save
        redirect_to action: :index
      else
        render action: :new
      end
    end

    private

    def set_params
    end

    def set_allotment
      @allotment = Healty::CheckAllotment.find(params[:allotment_id])
    end

    def set_unit
      @unit  = @allotment.units.find(params[:unit_id])
    end

  end
end
