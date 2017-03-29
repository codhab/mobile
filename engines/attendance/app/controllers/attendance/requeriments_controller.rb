require_dependency 'attendance/application_controller'

module Attendance
  class RequerimentsController < ApplicationController


    def index
      @requeriments = current_cadastre.assessments
    end

    def new
      @requeriment = current_cadastre.assessment_forms.new
    end

    def create
      @requeriment = current_cadastre.assessment_forms.new(set_params)
      @service = Core::Protocol::AssessmentService.new(@requeriment)
      if @service.app_requeriment!(current_cadastre)
         redirect_to requeriments_path
      else
        render action: :new
      end
    end

    def show
      @requeriment = current_cadastre.assessments.find(params[:id])
    end

    private

    def set_params
      params.require(:protocol_assessment_form).permit(:description_subject, digital_document_forms_attributes: [:doc_path, :_destroy, :id])
    end

  end
end
