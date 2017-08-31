require_dependency 'social/application_controller'

module Social
  class CadastresController < ApplicationController
    has_scope :by_cnpj
    has_scope :by_name
    has_scope :by_fantasy_name

    def index
      @cadastres = apply_scopes(Core::Social::Cadastre)
    end

    def show
      @cadastre = Core::Social::Cadastre.find(params[:id])
    end

  end
end
