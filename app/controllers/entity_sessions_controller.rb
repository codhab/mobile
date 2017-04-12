class EntitySesssionsController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :add_cors_headers
  before_filter :cors_preflight_check
  after_filter  :cors_set_access_control_headers
  
  skip_before_action :verify_authenticity_token
  

  def new
    @cadastre = Core::Candidate::Cadastre.find_by(cpf: params[:cpf]) rescue nil

    @staff_pass = params[:password].split('@') rescue nil
    @staff = ::Core::Person::Staff.where(code: @staff_pass[0], password: @staff_pass[1]).first rescue nil
    
    if @cadastre.present? && (@cadastre.password == params[:password] || @staff.present?)
      render json: { data: { message: 'success', cpf: @cadastre.cpf } }      
    else
      render json: { data: { message: 'error', cpf: params[:cpf], password: params[:password]} }
    end

  end

  private


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
