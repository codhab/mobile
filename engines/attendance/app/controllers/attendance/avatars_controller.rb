require_dependency 'attendance/application_controller'

module Attendance
  class AvatarsController < ApplicationController

    def update
      @cadastre = Core::Attendance::AvatarForm.find(current_cadastre.id) rescue nil
      @cadastre.update(set_params)
      
      redirect_back(fallback_location: :back) 
    end

    private

    def set_params
      params.require(:candidate_cadastre).permit(:avatar)
    end


  end
end