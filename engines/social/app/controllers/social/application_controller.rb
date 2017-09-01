require_dependency 'application_controller'

module Social
  class ApplicationController < ApplicationController
    protect_from_forgery with: :exception

    helper_method :current_social

    before_filter :add_cors_headers
    before_action :allow_iframe
    before_filter :cors_preflight_check
    after_filter  :cors_set_access_control_headers

    private

    def current_social

      if !params[:cnpj].blank?
        @social = ::Core::Social::Cadastre.find_by(cnpj: params[:cnpj]) rescue nil
        @social = ::Core::Social::CadastrePresenter.new(@social) rescue nil
        @social = ::Core::Social::CadastrePolicy.new(@social) rescue nil

        session[:social_id] = @social.id
      else
        @social = ::Core::Social::Cadastre.find(session[:social_id]) rescue nil
        @social = ::Core::Social::CadastrePresenter.new(@social) rescue nil
        @social = ::Core::Social::CadastrePolicy.new(@social) rescue nil
      end

      return @social

    end

    def allow_iframe
      response.headers.delete('X-Frame-Options')
    end

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
      headers['Access-Control-Max-Age'] = "1728000"
    end

    def cors_preflight_check
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
    end

    def add_cors_headers
      origin = request.headers["Origin"]
      unless (not origin.nil?) and (origin == "http://localhost" or origin.starts_with? "http://localhost:")
        origin = "http://www.codhab.df.gov.br:81"
      end
      headers['Access-Control-Allow-Origin'] = origin
      headers['Access-Control-Allow-Methods'] = 'POST, GET'
      allow_headers = request.headers["Access-Control-Request-Headers"]
      if allow_headers.nil?
        #shouldn't happen, but better be safe
        allow_headers = 'Origin, Authorization, Accept, Content-Type'
      end
      headers['Access-Control-Allow-Headers'] = allow_headers
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Max-Age'] = '1728000'
    end

  end
end
