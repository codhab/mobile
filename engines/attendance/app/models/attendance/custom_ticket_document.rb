require_dependency 'attendance/custom_ticket'

module Attendance
  class CustomTicketDocument < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.attendance_custom_ticket_documents'

    belongs_to :ticket, class_name: 'Attendance::CustomTicket'


    validates :attachment, file_size: { less_than_or_equal_to: 50.megabytes },
                      file_content_type: { allow: ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf'] }

    mount_uploader :attachment, Core::Attendance::DocumentUploader


  end
end
