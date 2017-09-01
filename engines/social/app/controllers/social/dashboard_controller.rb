require_dependency 'social/application_controller'

module Social
  class DashboardController < ApplicationController

    def index
    end

    def show
      @social = current_social
    end

  end
end
