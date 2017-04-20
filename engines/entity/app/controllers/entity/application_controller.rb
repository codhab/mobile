require_dependency 'application_controller'

module Entity
  class ApplicationController < ApplicationController
    protect_from_forgery with: :exception

    helper_method :current_entity
    
    private

    def current_entity
      if session[:entity_id].present?
        @entity = ::Core::Entity::Cadastre.find(session[:entity_id]) rescue nil
      else
        @entity = ::Core::Entity::Cadastre.find_by(cnpj: params[:cnpj]) rescue nil
        session[:entity_id] = params[:cnpj] if !@entity.nil?
      end

      return @entity
    end

  end
end
