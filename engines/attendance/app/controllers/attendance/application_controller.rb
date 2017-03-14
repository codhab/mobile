module Attendance
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    layout 'application'

    helper_method :current_cadastre

    private

    def current_cadastre
      cadastre = CandidateCadastre.find(296560)

      return cadastre
    end

  end
end
