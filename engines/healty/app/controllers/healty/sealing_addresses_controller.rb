require_dependency 'healty/application_controller'

module Healty
  class SealingAddressesController < ApplicationController # :nodoc:
    before_action :set_addresses
    before_action :set_address, only: %i[edit update destroy show]

    has_scope :by_city
    has_scope :by_address
    has_scope :by_name
    has_scope :by_cpf

    def index; end

    def new
      @address = Core::Healty::SealingAddress.new
    end

    def create
      @address = Core::Healty::SealingAddress.new(set_params)
      @address.staff_id = session[:staff_id]
      if @address.save
        redirect_to  sealing_address_path(@address)
      else
        render :new
      end
    end

    def edit; end

    def update
      @address.update(set_params)
    end

    def destroy
      @address.destroy
    end

    def show; end

    private

    def set_params
      params.require(:sealing_address).permit(:name, :observation, :city_id, :address,
                                              :sub_area_id, :cpf, :status, :lat, :lng)
    end

    def set_addresses
      @addresses = apply_scopes(Core::Healty::SealingAddress).all
    end

    def set_address
      @address = Core::Healty::SealingAddress.find(params[:id])
    end
  end
end
