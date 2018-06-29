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

    def edit
      @check = @unit.checks.last
    end

    def update
      @check = @unit.checks.last

      if params[:check][:password].blank?
        params[:check].delete(:password)
        params[:check].delete(:password_confirmation)
      end
      
      if @check.update(set_params)
        redirect_to action: :index
      else
        render action: :new
      end
    end

    private

    def set_params
      params.require(:check).permit(:name, :cpf, :born, :telephone, :celphone, :lat_lng, :password, :password_confirmation)
    end

    def set_allotment
      @allotment = Healty::CheckAllotment.find(params[:allotment_id])
    end

    def set_unit
      @unit  = @allotment.units.find(params[:unit_id])
    end

  end
end
