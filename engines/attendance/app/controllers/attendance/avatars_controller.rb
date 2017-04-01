require_dependency 'attendance/application_controller'

module Attendance
  class AvatarsController < ApplicationController

    def update
      current_cadastre.update(set_params)
      redirect_to :back
    end

    private

    def set_params
      params.require(:candidate_cadastre).permit(:avatar)
    end


  end
end