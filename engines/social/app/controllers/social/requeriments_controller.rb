require_dependency 'social/application_controller'

module Social
  class RequerimentsController < ApplicationController


    def index
      @requeriments = Core::Protocol::Assessment.where(cnpj: current_social.cnpj)
    end

    def new
      @requeriment  = Core::Social::AssessmentForm.where(cnpj: current_social.cnpj).new
    end

    def create
      @requeriment = Core::Social::AssessmentForm.where(cnpj: current_social.cnpj).new(set_params)
      @service = Core::Protocol::AssessmentService.new(@requeriment)

      if @service.app_requeriment!(nil, current_social)
         redirect_to requeriments_path
      else
        render action: :new
      end
    end

    def show
      @requeriment = Core::Social::AssessmentForm.where(cnpj: current_social.cnpj).find(params[:id])
    end

    private

    def set_params
      params.require(:social_assessment_form).permit(:description_subject, digital_document_forms_attributes: [:doc_path, :_destroy, :id])
    end

  end
end
