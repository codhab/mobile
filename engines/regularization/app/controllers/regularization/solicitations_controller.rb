require_dependency 'regularization/application_controller'

module Regularization
  class SolicitationsController < ApplicationController # :nodoc:
    before_action :set_solicitation, only: [:show, :edit, :update]

    has_scope :city_id
    has_scope :by_block
    has_scope :by_group
    has_scope :by_unit


    def index
      cpf = params[:by_cpf].gsub('-','').gsub('.','') if params[:by_cpf].present?
      @verify = Core::Candidate::Cadastre.where(cpf: cpf)
                                       .where.not(program_id: [3, 6])
      if params[:by_cpf].present?
        if @verify.present?
          redirect_to error_path
        else          
          redirect_to new_solicitation_path(subject_id: params[:subject_id], cpf: cpf)
        end
      end
    end

    def new
      @verify_reg = Core::Candidate::Cadastre.where(cpf: params[:cpf])
                                       .where(program_id: [3, 6]).first

        @solicitation = Core::Regularization::Solicitation.new

    end


    def create
      @solicitation = Core::Regularization::Solicitation.new(set_params)
      @solicitation.cpf = @solicitation.cpf.gsub('-','').gsub('.','')
      @solicitation.city_id    = params[:city_id]
      @solicitation.unit_id    = params[:by_unit]
      @solicitation.subject_id = params[:subject_id]

      @verify = Core::Candidate::Cadastre.where(cpf: @solicitation.cpf.gsub('-','').gsub('.',''))
                                         .where.not(program_id: [3, 6])
      if @verify.present?
        redirect_to error_path()
      else
        if @solicitation.save
          redirect_to new_solicitation_document_path(@solicitation)
        else
          render :new
        end
      end
    end

    def edit; end

    def update
      @solicitation.update(set_params)
    end

    def show; end

    def block
      city = params[:city_id]
      render json: @blocks = Core::Address::Unit.select(:block).where(city_id: city).distinct.order(:block)
    end

    def group
      city = params[:city_id]
      block = params[:by_block]
      render json: @groups = Core::Address::Unit.select(:group).where(city_id: city, block: block).distinct.order(:group)
    end

    def unit
      city = params[:city_id]
      block = params[:by_block]
      group = params[:by_group]
      render json: @units = Core::Address::Unit.select(:unit).where(city_id: city, block: block, group: group).order(:unit)
    end


    private

    def set_params

      params.require(:regularization_solicitation).permit(:name, :phone,:cpf, :subject_id, :content, :city_id , :address, :email, :unit_id)
    end

    def set_solicitation
      @solicitation = Core::Regularization::Solicitation.find(params[:id])
    end

  end
end
