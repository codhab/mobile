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
      number = service.set_number!(nil,27)
      @requeriment.document_number = number
      if @requeriment.save

        flash[:title]      = "Operação realizada com sucesso!"
        flash[:message]    = "Os seus dados foram atualizados com sucesso, veja o detalhamento abaixo"
        flash[:html_class] = "success"     

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
