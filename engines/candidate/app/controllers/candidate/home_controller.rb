require_dependency 'candidate/application_controller'
require_dependency 'core/attendance/cadastre_presenter'
require_dependency 'core/attendance/cadastre_policy'
module Candidate
  class HomeController < ApplicationController

    def show
      @ticket_presenter = Core::Attendance::CadastrePresenter.new(current_cadastre)
      @ticket_policy    = Core::Attendance::CadastrePolicy.new(@ticket_presenter)
      @ticket_policy    = Core::Project::CadastrePolicy.new(@ticket_policy)
      @document = Core::Document::DataPrint.where(cpf: current_cadastre.cpf, status: true).last
    end

    def accept
      @indication = current_cadastre.enterprise_cadastres.find(params[:id])
      @indication.accepted = true
      @indication.accepted_observation = 'Indicação aceita pelo candidato via app.'
      @indication.accepted_date = Time.now
      @indication.save
      @message = "Indicação aceita com sucesso."
      #redirect_to root_path(m: @message)
    end

    def form
    end

    def not_accept
      @indication = current_cadastre.enterprise_cadastres.find(params[:id])
    end

    def not_accepted
      @indication = current_cadastre.enterprise_cadastres.find(params[:candidate_enterprise_cadastre][:id])
      @indication.inactive = true
      @indication.inactive_date = Time.now
      @indication.accepted = false
      @indication.accepted_observation = params[:candidate_enterprise_cadastre][:accepted_observation]
      @indication.accepted_date = Time.now
      @indication.save
      @message = "Indicação recusada com sucesso."
      redirect_to root_path(m: @message)
    end
  end
end
