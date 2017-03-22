require_dependency 'application_helper'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  layout 'application'
  
  before_action :allow_iframe
  before_action :add_cors_headers
  
  helper_method :current_cadastre
  

  private

  def current_cadastre

    if params[:cpf].present?
      cadastre = ::Core::Candidate::Cadastre.find_by(cpf: params[:cpf])
      session[:user_id] = presenter.id
    else
      cadastre = ::Core::Candidate::Cadastre.find(session[:user_id])
    end
    
    presenter = Core::Candidate::CadastrePresenter.new(cadastre)
    policy    = Core::Candidate::CadastrePolicy.new(presenter)

    return policy
  end

  def allow_iframe
    response.headers.delete('X-Frame-Options')
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
