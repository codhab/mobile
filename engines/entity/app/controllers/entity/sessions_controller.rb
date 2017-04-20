require_dependency 'entity/application_controller'

module Entity
  class SessionsController < ApplicationController
    
    def new
      @entity = Core::Entity::Cadastre.where(cnpj: params[:cnpj], password: params[:password]).first


      if @entity.present? 
        render json: { data: { message: 'success', cnpj: @entity.cnpj } }      
      else
        render json: { data: { message: 'error', cnpj: params[:cnpj] } }
      end
  
    end

  end
end