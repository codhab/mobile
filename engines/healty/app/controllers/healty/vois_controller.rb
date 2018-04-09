require_dependency 'healty/application_controller'

module Healty
  class VoisController < ApplicationController # :nodoc:
    before_action :set_voi, only: %i[edit update show]

    def index
      @vois = Core::Healty::Voi.take(5)
    end

    def new
      @voi = Core::Healty::VoiForm.new
    end

    def create
      @voi = Core::Healty::VoiForm.new(set_params)
      @voi.due = @voi.due.present? ? @voi.due : Date.current
      @voi.staff_id = session[:staff_id]
      if @voi.save
        redirect_to voi_path(@voi)
      else
        render :new
      end
    end

    def all 
      @vois = Core::Healty::Voi.all
    end

    def edit; end

    def update
      @voi.update(set_params)
    end

    def show; end

    def block
      city = params[:by_city]
      render json: @blocks = Core::Address::Unit.select(:block).where(city_id: city).distinct.order(:block)
    end

    def group
      city = params[:by_city]
      block = params[:by_block]
      render json: @groups = Core::Address::Unit.select(:group).where(city_id: city, block: block).distinct.order(:group)
    end

    def unit
      city = params[:by_city]
      block = params[:by_block]
      group = params[:by_group]
      render json: @units = Core::Address::Unit.select(:unit).where(city_id: city, block: block, group: group).order(:unit)
    end


    private

    def set_params
      params.require(:voi_form).permit(:name, :cpf, :voi_type_id, :cadastre_id, :due,
                                       :city_id, :address, :report, :origin_type_id,
                                       :report_reason_id)
    end

    def set_voi
      @voi = Core::Healty::VoiForm.find(params[:id])
    end
  end
end
