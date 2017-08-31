require_dependency 'social/application_controller'

module Social
  class SessionsController < ApplicationController

    skip_before_action :verify_authenticity_token


    def new
      @social = Core::Social::Cadastre.where(cnpj: params[:cnpj], password: params[:password]).first


      if @social.present?
        render json: { data: { message: 'success', cnpj: @social.cnpj } }
      else
        render json: { data: { message: 'error', cnpj: params[:cnpj] } }
      end

    end

  end
end
