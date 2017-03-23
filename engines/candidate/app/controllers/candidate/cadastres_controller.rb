module Candidate
  class CadastresController < ApplicationController

    def show
    end

    def detail
      @cadastre = current_cadastre
    end

    def dependent
      @dependents = current_cadastre.dependents.where('kinship_id <> 6')
      @spouse = current_cadastre.dependents.where(kinship_id: 6).first
    end

    def pontuation
      @pontuations = current_cadastre.pontuations
    end

    def entity
      @entity = current_cadastre.old_candidates.last
    end

    def situation
      @situations = current_cadastre.cadastre_situations
    end

    def schedule
      @schedules = current_cadastre.schedules
    end

    def document
      @documents = current_cadastre.assessments.where('document_type_id <> 26')
    end

    def address
      @address = current_cadastre.current_cadastre_address
    end

    def occurrence
      @iptus = current_cadastre.iptus
    end

  end
end
