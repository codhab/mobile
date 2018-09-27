require_dependency 'entity/application_controller'

module Entity
  class CandidatesController < ApplicationController

    def index
      @candidates = Core::Entity::Candidate.where(cadastre_id: current_entity.id)
    end

  end
end
