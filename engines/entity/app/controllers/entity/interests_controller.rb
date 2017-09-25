require_dependency 'entity/application_controller'

module Entity
  class InterestsController < ApplicationController
    before_action :set_address, only: [:new, :create, :send_mail]

    def index
      @enterprise = Core::Entity::Enterprise.where(entity_id: current_entity.id)
      @enterprise = (!current_entity.enterprises.present? && !@enterprise.present?)
    end

    def new
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id, allotment_id: 2).new
      
    end

    def create
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id, allotment_id: 2).new(set_params)

      if @interest.save 

        Entity::RecoveryMailer.simple(@interest.entity.email).deliver_now rescue nil

        redirect_to entity_interest_path(@interest)
      else 
        flash[:error] = t :error
        render action: :new
      end

    end

    def show
      @interest = current_entity.interests.find(params[:id])
    end

    def send_mail
      @interest = current_entity.interests.find(params[:entity_interest_id])

      begin 

        Entity::RecoveryMailer.simple(@interest, @interest.entity.email).deliver_now 
        
        flash[:success] = t :success
      
      rescue Exception => e
        puts e
      end

      redirect_to entity_interest_path(@interest)
    end

    private

    def set_params
      params.fetch(:entity_interest_form, {}).permit(unit_sale_ids: [])
    end


    def set_address
      @addresses = Core::Entity::UnitSale.where(status: true)
    end

  end
end
