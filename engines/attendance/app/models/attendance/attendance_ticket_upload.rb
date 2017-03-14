module Attendance
  class AttendanceTicketUpload < ApplicationRecord
    self.table_name = 'extranet.attendance_ticket_uploads'

    validates :upload_path, file_size: { less_than_or_equal_to: 5.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png', 'image/bmp', 'application/pdf'] } 

    mount_uploader :upload_path, Attendance::DocumentUploader
  end
end