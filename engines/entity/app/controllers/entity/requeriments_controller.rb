require_dependency 'entity/application_controller'

module Entity
  class RequerimentsController < ApplicationController


    def index
      @requeriments = Core::Protocol::Assessment.where(cnpj: current_entity.cnpj)
    end

    def new
      @requeriment  = Core::Entity::AssessmentForm.where(cnpj: current_entity.cnpj).new
    end

    def create
      @requeriment = Core::Entity::AssessmentForm.where(cnpj: current_entity.cnpj).new(set_params)
      @service = Core::Protocol::AssessmentService.new(@requeriment)
      
      if @service.app_requeriment!(nil, current_entity)
         redirect_to requeriments_path
      else
        render action: :new
      end
    end

    def show
      @requeriment = Core::Entity::AssessmentForm.where(cnpj: current_entity.cnpj).find(params[:id])
    end

    private

    def set_params
      params.require(:entity_assessment_form).permit(:description_subject, digital_document_forms_attributes: [:doc_path, :_destroy, :id])
    end

  end
end
