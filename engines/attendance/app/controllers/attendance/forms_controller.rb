require_dependency 'attendance/application_controller'

module Attendance
  class FormsController < ApplicationController
    before_action :set_form

    def new
      @current_form = @form.form_values.where("store->> 'cadastre_id' = '?'", current_cadastre.id).first rescue nil
      
      if @current_form.present?
        redirect_to form_path(id: @current_form.id, form_id: @form)
      else
        @form_value = @form.form_values.new
      end
    end

    def create
      @form_value = @form.form_values.new(set_params)
      @form_value.cadastre_id = current_cadastre.id

      if @form_value.save
        redirect_to form_path(id: @form_value, form_id: @form)
      else
        render action: :new
      end
    end

    def show
      @form_value = @form.form_values.where("store->> 'cadastre_id' = '?'", current_cadastre.id).first
    end

    private

    def set_params
      params.require(:attendance_form_value)
            .permit(:children_count, :children_resident, :special_children,
                    :resident_room, :income, :work_company,
                    :children_major, :resident_photo, :roof_photo,
                    :resident_type, :resident_status, :kitchen_photo)
    end
    def set_form
      @form = Core::Attendance::Form.find(params[:form_id])
    end

  end
end