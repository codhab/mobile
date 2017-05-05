require_dependency 'protocol/application_controller'
module Protocol
  class ConductsController < ApplicationController # :nodoc:
    def index
      @staff = Core::Person::Staff.find(session[:staff_id])
      if params[:deviceid].present? && params[:pushtoken].present?
        @staff.update(mobile_user_token: params[:deviceid], mobile_push_token: params[:pushtoken])
      end
      @due_documents = Core::View::DueDocument.where('responded is not true and sector_destiny_id = ?', @staff.sector_current_id) if @staff.present?
    end
  end
end
