require_dependency 'protocol/application_controller'
module Protocol
  class ConductsController < ApplicationController # :nodoc:
    def index
      @staff = Core::Person::Staff.find(session[:staff_id])
      @due_documents = Core::View::DueDocument.where('responded is not true and sector_destiny_id = ?', @staff.sector_current_id)
    end
  end
end
