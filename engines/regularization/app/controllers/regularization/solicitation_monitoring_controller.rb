require_dependency 'regularization/application_controller'

module Regularization
  class SolicitationMonitoringController < ApplicationController # :nodoc:
    has_scope :by_cpf

    def index
      cpf = params[:by_cpf].gsub('-','').gsub('.','') if params[:by_cpf].present?
      @cpfs = Core::Regularization::SolicitationMonitoring.where(cpf: cpf)
      # @answer = Core::Regularization::SolicitationAnswer.where(solicitation_id: )
    end

  end
end
