require_dependency 'healty/application_controller'

module Healty
  class VoiActivitiesController < ApplicationController # :nodoc:
    before_action :set_voi
    before_action :set_vois, only: %i[create update destroy]
    before_action :set_voi_activity, only: %i[edit update destroy]

    def index
      @voi_activity = Core::Healty::VoiActivity.new
    end

    def create
      @voi_activity = Core::Healty::VoiActivity.new(set_params)
      @voi_activity.title = 'Observação preenchida via APP'
      @voi_activity.voi_id = @voi.id
      @voi_activity.staff_id = session[:staff_id]
      @voi_activity.date = Date.current
      @voi_activity.save
      redirect_to voi_activities_path(@voi)
    end

    def edit; end

    def update
      @voi_activity.update(set_params)
    end

    def destroy
      @voi_activity.destroy
    end

    private

    def set_params
      params.require(:voi_activity).permit(:title, :activity_type_id, :description,
                                           :data)
    end

    def set_vois
      @vois = Core::Healty::Voi.all
    end

    def set_voi
      @voi = Core::Healty::Voi.find(params[:voi_id])
      @voi_activities = @voi.voi_activities.order(id: :desc).all
    end

    def set_voi_activity
      @voi_activity = Core::Healty::VoiActivity.find(params[:id])
    end
  end
end
