require_dependency 'attendance/application_controller'

module Attendance
  class RequerimentsController < ApplicationController


    def index
      @requeriments = current_cadastre.assessments
    end

    def new
      @requeriment = current_cadastre.assessments.new
      @requeriment.digital_documents.build
    end

    def create
      @requeriment = current_cadastre.assessments.new(set_params)
      @requeriment.document_type_id = 26 #external requeriment
      @requeriment.subject_id       = 1498 #request
      @requeriment.recipient        = current_cadastre.name
      service = Core::Protocol::AssessmentService.new(@requeriment)

      sector =  ([1,2,4,5,7,9,10].include? current_cadastre.program_id) ? 27 : 30

      number = service.set_number!(nil,sector)

      @requeriment.document_number = number

      if @requeriment.save
         service.set_conduct!(@requeriment,nil,sector)
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
      params.require(:protocol_assessment).permit(:description_subject, digital_documents_attributes: [:doc_path, :_destroy, :id])
    end

  end
end
