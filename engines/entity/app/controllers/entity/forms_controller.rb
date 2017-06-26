require_dependency 'entity/application_controller'

module Entity
  class FormsController < ApplicationController
    before_action :set_form, except: [:edit, :update]

    def new
      @current_form = @form.form_values.where("store->> 'cadastre_id' = '?'", current_entity.id).first rescue nil
      
      if @current_form.present?
        redirect_to form_path(id: @current_form.id, form_id: @form)
      else
        @form_value = @form.form_values.new
        @form_value.write_attributes
      end
    end

    def create
      @form_value = @form.form_values.new
      @form_value.write_attributes
      @form_value.cadastre_id = current_entity.id
      @form_value.attributes= set_params
      
      if @form_value.save
        redirect_to form_path(id: @form_value, form_id: @form)
      else
        render action: :new
      end
    end

    def edit
      @form_value = Core::Attendance::FormValue.find(params[:id])
      @form       = @form_value.form
    end

    def update
      
    end


    def show
      @form_value = @form.form_values.where("store->> 'cadastre_id' = '?'", current_entity.id).first
    end

    private

    def set_params
      @fields = @form.form_fields.map(&:name).split(',')

      params.require(:attendance_form_value)
            .permit(@fields)
    end
    def set_form
      @form = Core::Attendance::Form.find(params[:form_id])
    end

  end
end