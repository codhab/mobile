require_dependency 'candidate/application_controller'

module Candidate
  class RequerimentsController < ApplicationController

    def index
      redirect_to action: :new
    end

    def new
      @requeriment = Core::Protocol::ExternalRequerimentForm.new
    end

    def create

      @requeriment = Core::Protocol::ExternalRequerimentForm.new(set_params)
      
      if @requeriment.valid?
        redirect_to action: :show
      else
        render action: :new
      end
    end

    def show
    end


    private

    def set_params
      params.require(:protocol_external_requeriment_form).permit(:cpf, :observation, :email)
    end


  end
end
