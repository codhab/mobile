module Candidate
  class CadastresController < ApplicationController

    has_scope :by_cpf

    def search
      if params[:by_cpf].present?
        @cadastre = apply_scopes(Core::Candidate::Cadastre).first
      else
        flash[:warning] = "Cadastro não encontrado."
      end
    end

    def result
      @cadastre = Core::Candidate::Cadastre.find(params[:id])
      @cadastre = Core::Candidate::CadastrePresenter.new(@cadastre)
    end

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

    def indication
      @indications = current_cadastre.enterprise_cadastres
    end

  end
end
