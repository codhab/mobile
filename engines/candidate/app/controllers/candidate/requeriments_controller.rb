require_dependency 'candidate/application_controller'

module Candidate
  class RequerimentsController < ApplicationController

    def index
      redirect_to action: :new
    end

    def new
      # @requeriment = Core::Protocol::ExternalRequerimentForm.new
      # @requeriment.digital_document_forms.new
      redirect_to '/regularization'

    end

    def create
      @requeriment = Core::Protocol::ExternalRequerimentForm.new(set_params)
      @service = Core::Protocol::AssessmentService.new(@requeriment)
      if simple_captcha_valid?
        if @service.requeriment_citzen_app!
          redirect_to requeriment_path(@requeriment)
        else
          render :new
        end
      else
        flash[:notice] = "Preencha o código secreto."
        render action: :new
      end
    end

    def show
      @requeriment = Core::Protocol::Assessment.find(params[:id])
    end


    private

    def set_params
      params.require(:protocol_external_requeriment_form).permit(:recipient, :cpf, :observation, :email,:address,:description_subject, digital_document_forms_attributes: [:doc_path, :_destroy, :id])
    end


  end
end
