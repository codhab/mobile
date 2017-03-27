class SessionsController < ApplicationController

  def new

    @cadastre = ::Candidate::Cadastre.find_by(cpf: params[:cpf])

    if @cadastre.present?
      
      @staff_pass = params[:password].split('@') rescue nil
      @staff = ::Person::Staff.where(code: @staff_pass[0], password: @staff_pass[1]) rescue nil

      if @cadastre.password == params[:password] || @staff.present?
        render json: { data: { message: 'success', cpf: @cadastre.cpf } }      
      else
        render json: { data: { message: 'error', cpf: params[:cpf], password: params[:password], params: params} }
      end
    end

  end

end
