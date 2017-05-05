require_dependency 'protocol/application_controller'
module Protocol
  class ConductsController < ApplicationController # :nodoc:
    def index
      @due_documents = Core::View::DueDocument.where('responded is not true and sector_destiny_id = ?', current_staff.sector_current_id) if current_staff.present?
    end
  end
end
