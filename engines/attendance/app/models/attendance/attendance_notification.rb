module Attendance
  class AttendanceNotification < ApplicationRecord
    self.table_name = 'extranet.attendance_notifications'
    
    belongs_to :cadastre, class_name: "::CandidateCadastre", foreign_key: :cadastre_id
    
    scope :unread, -> {
      where(read: false)
    }    
  end
end