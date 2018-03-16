require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomImagesController < CustomApplicationController
      def show
        @document = Attendance::CustomTicketDocument.find(params[:id])
      end
    end
  end
end
