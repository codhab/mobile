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
      @requeriment.document_type_id = 26 #external requeriment

      @requeriment.recipient        = current_cadastre.name
      @requeriment.finalized        = false
      service = Core::Protocol::AssessmentService.new(@requeriment)

     if ([1,2,4,5,7,9,10].include? current_cadastre.program_id)
       sector = 27
       @requeriment.subject_id = 1746 #request
     else
        sector = 30
        @requeriment.subject_id = 1747 #request
     end

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
      params.require(:protocol_assessment_form).permit(:description_subject, digital_documents_attributes: [:doc_path, :_destroy, :id])
    end

  end
end
