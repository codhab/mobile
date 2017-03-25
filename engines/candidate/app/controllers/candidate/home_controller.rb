require_dependency 'candidate/application_controller'
require_dependency 'core/attendance/cadastre_presenter'
require_dependency 'core/attendance/cadastre_policy'
module Candidate
  class HomeController < ApplicationController 
    
    def show
      @ticket_presenter = Core::Attendance::CadastrePresenter.new(current_cadastre)
      @ticket_policy    = Core::Attendance::CadastrePolicy.new(@ticket_presenter)
    end
    
  end
end