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
      @pre_register.cpf = @pre_register.cpf.gsub('-','').gsub('.','')
      @pre_register.city_id = params[:city_id]

        if @pre_register.save
          redirect_to done_path
        else
          render :new
        end

    end
    def done
    end

    private

    def set_params
      params.require(:pre_register).permit(:name,:cpf, :cad, :city_id , :address, :email, :latitude, :longitude)
    end

    def set_pre_register
      @pre_register = Core::TechnicalAssistance::PreRegister.find(params[:id])
    end
  end
end
