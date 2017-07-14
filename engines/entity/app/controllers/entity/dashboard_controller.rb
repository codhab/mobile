require_dependency 'entity/application_controller'

module Entity
  class DashboardController < ApplicationController

    def index
    end

    def show
      @entity = current_entity
    end

  end
end
