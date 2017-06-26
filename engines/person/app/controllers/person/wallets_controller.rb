require_dependency 'person/application_controller'

module Person
  class WalletsController < ApplicationController
    
    has_scope :by_address
    has_scope :by_block
    has_scope :by_city

    def index
      if params[:by_city].present?
        @addresses = apply_scopes(WalletAddress).all.order(:address_agenda)
      else
        @addresses = {}
      end
    end

    def show
      @address = WalletAddress.find(params[:id])
    end
    
    def edit
      @address = WalletAddress.find(params[:id])
      @address.data_reference_uploads.build
      
    end

    def update
      @address = WalletAddress.find(params[:id])
      @address.update(set_params)
      @address.update(updated: true, updated_date: Date.current)

      redirect_to action: :show
    end


    def by_city
      @addresses = WalletAddress.where(city_agenda_id: params[:city_id])
                                .where.not(block: ' - ')
                                .distinct
                                .pluck(:block)
                                .sort
      render json: @addresses
    end

    def by_block
      @addresses = WalletAddress.select(:id, :address_agenda)
                                .where(city_agenda_id: params[:city_id], block: params[:block])
                                .order(:address_agenda)

      render json: @addresses
    end

    private

    def set_params
      params.require(:wallet_address).permit(:cpf, data_reference_uploads_attributes: [:_id, :_destroy, :data_reference_id, :document])
    end

  end
end