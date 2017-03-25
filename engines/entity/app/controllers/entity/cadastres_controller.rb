require_dependency 'application_controller'

module Entity
  class CadastresController < ApplicationController
    has_scope :by_cnpj

    def index
    end

    def search
      if params[:by_cnpj].present?
        @cadastre = apply_scopes(Core::Entity::Cadastre).first
      else
        flash[:warning] = "Cadastro não encontrado."
      end
    end

    def show
      @cadastre = Core::Entity::Cadastre.find(params[:id])
    end

  end
end
