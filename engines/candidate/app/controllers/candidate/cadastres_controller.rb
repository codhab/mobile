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



  end
end
