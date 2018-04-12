require_dependency 'regularization/application_controller'

module Regularization
  class SolicitationsController < ApplicationController # :nodoc:
    before_action :set_solicitation, only: [:show, :edit, :update]

    has_scope :city_id
    has_scope :by_block
    has_scope :by_group
    has_scope :by_unit
    
    
    def index
     
    end

    def new
      @solicitation = Core::Regularization::Solicitation.new
    end

    
    def create
      @solicitation = Core::Regularization::Solicitation.new(set_params)
      @solicitation.city_id = params[:city_id]
      @solicitation.unit_id = params[:by_unit]
      if @solicitation.save
        # redirect_to action: 'index'
      else
        render :new
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
      params.require(:regularization_solicitation).permit(:name, :cpf, :subject_id, :content, :city_id , :address, :email, :unit_id)
    end

    #  def set_unit
    #   @unit = Core::Address::Unit.find(params[:unit_id])
    # end

    def set_solicitation
      @solicitation = Core::Regularization::Solicitation.find(params[:id])
    end

  end
end