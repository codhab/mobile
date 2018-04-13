require_dependency 'regularization/application_controller'

module Regularization
  class SolicitationMonitoringController < ApplicationController # :nodoc:
    has_scope :by_cpf
    
    def index
      @cpfs = Core::Regularization::SolicitationMonitoring.where(cpf: params[:by_cpf].gsub('-','').gsub('.',''))
    end

  end
end
