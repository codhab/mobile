require_dependency 'attendance/application_controller'

module Attendance
  class OpenDoorsController < ApplicationController

    def index
      @projects = Core::Project::Enterprise.manifestation_enabled
    end

    def show
      @project  = Core::Project::Enterprise.manifestation_enabled.find(params[:id])
    end

    def new
      @project  = Core::Project::Enterprise.manifestation_enabled.find(params[:id])
      @service  = Core::Project::ManifestationService.new(cadastre: current_cadastre, project: @project)
      @service.indicate!
    
      redirect_to open_doors_path
    end

    def delete
      @project  = Core::Project::Enterprise.manifestation_enabled.find(params[:open_door_id])
    end

    def destroy
      @project  = Core::Project::Enterprise.manifestation_enabled.find(params[:id])
      @service  = Core::Project::ManifestationService.new(cadastre: current_cadastre, project: @project)
      @service.cancel_indicate!
       
      redirect_to open_doors_path
    end

    private

    def set_params
    end

  end
end