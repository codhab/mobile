require_dependency 'entity/application_controller'

module Entity
  class CadastresController < ApplicationController
    has_scope :by_cnpj
    has_scope :by_name
    has_scope :by_fantasy_name

    def index
      @cadastres = apply_scopes(Core::Entity::Cadastre)
    end

    def show
      @cadastre = Core::Entity::Cadastre.find(params[:id])
    end

  end
end
