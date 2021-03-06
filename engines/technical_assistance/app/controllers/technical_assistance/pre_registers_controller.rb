require_dependency 'technical_assistance/application_controller'
module TechnicalAssistance
  class PreRegistersController < ApplicationController
    before_action :set_pre_register, only: [:show, :edit, :update]

    def index
    end

    def new
      @pre_register = TechnicalAssistance::PreRegister.new
    end


    def create
      @pre_register = TechnicalAssistance::PreRegister.new(set_params)

      if @pre_register.save
        redirect_to pre_register_path(@pre_register)
      else
        render :new
      end

    end

    def show; end

    def burgh
      city = params[:city_id]
      render json: @burgh = Core::Address::Burgh.where(city_id: city)
    end

    private

    def set_params
      params.require(:pre_register).permit(:name, :cpf, :cad, :city_id, :address, :email,
                                           :burgh_id, :latitude, :longitude, :phone, :special_condition)
    end

    def set_pre_register
      @pre_register = TechnicalAssistance::PreRegister.find(params[:id])
    end
  end
end
