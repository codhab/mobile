require_dependency 'attendance/application_controller'

module Entity
  class RequerimentsController < ApplicationController


    def index
      @requeriments = current_entity.assessments.requeriments
    end

    def new
      @requeriment = current_entity.assessment_forms.new
    end

    def create
      @requeriment = current_entity.assessment_forms.new(set_params)
      @service = Core::Protocol::AssessmentService.new(@requeriment)
      if @service.app_requeriment!(current_entity)
         redirect_to requeriments_path
      else
        render action: :new
      end
    end

    def show
      @requeriment = current_entity.assessments.find(params[:id])
    end

    private

    def set_params
      params.require(:protocol_assessment_form).permit(:description_subject, digital_document_forms_attributes: [:doc_path, :_destroy, :id])
    end

  end
end
