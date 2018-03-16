require_dependency 'healty/application_controller'

module Healty
  class UnitVoisController < ApplicationController # :nodoc:
    before_action :set_unit, except: %i[index]
    before_action :set_voi, only: %i[edit update show]

    has_scope :by_city
    has_scope :by_block
    has_scope :by_group
    has_scope :by_unit

    def index
      if params[:by_unit].present?
        @units = apply_scopes(Core::Address::Unit).all
      end
    end

    def new
      @voi = Core::Healty::UnitVoiForm.new
    end

    def create
      @voi = Core::Healty::UnitVoiForm.new(set_params)
      @voi.unit_id = @unit.id
      @voi.due = @voi.due.present? ? @voi.due : Date.current
      if @voi.save
        redirect_to voi_path(@voi)
      else
        render :new
      end
    end

    def edit; end

    def update
      @voi.update(set_params)
    end

    def show; end


    private

    def set_params
      params.require(:unit_voi_form).permit(:name, :cpf, :voi_type_id, :cadastre_id, :due,
                                       :city_id, :address, :report, :origin_type_id,
                                       :report_reason_id)
    end

    def set_unit
      @unit = Core::Address::Unit.find(params[:unit_id])
    end

    def set_voi
      @voi = Core::Healty::VoiForm.find(params[:id])
    end
  end
end
