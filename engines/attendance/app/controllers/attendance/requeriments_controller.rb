require_dependency 'attendance/application_controller'

module Attendance
  class RequerimentsController < ApplicationController
    

    def index
      @requeriments = CoreAttendance::Protocol::Assessment.by_candidate(current_cadastre)
    end

    def new
      @requeriment = CoreAttendance::Protocol::Assessment.by_candidate(current_cadastre).new
    end

    def create
      @requeriment = CoreAttendance::Protocol::Assessment.by_candidate(current_cadastre).new(set_params)

      if @requeriment.save

        flash[:title]      = "Operação realizada com sucesso!"
        flash[:message]    = "Os seus dados foram atualizados com sucesso, veja o detalhamento abaixo"
        flash[:html_class] = "success"
      
        @notification_service = CoreAttendance::NotificationService.new(cadastre: current_cadastre)
        
        @notification_service.create_notification do |service| 
          service.category_id = 2
          service.title       = "Requerimento criado com sucesso."
          service.content     = "Requerimento criado com sucesso. Nº #{@requeriment.protocol_number}"
          service.link        = ''
          service.push        = true
        end

        redirect_to requeriments_path
      else
        render action: :new
      end
    end

    def show
      @requeriment = CoreAttendance::Protocol::Assessment.find(params[:id])
    end

    private

    def set_params
      params.fetch(:protocol_assessment, {})
            .permit(:description_subject)
    end
    
  end
end