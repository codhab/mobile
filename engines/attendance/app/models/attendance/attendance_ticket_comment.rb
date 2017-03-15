module Attendance
  class AttendanceTicketComment < ApplicationRecord
    self.table_name = 'extranet.attendance_ticket_comments'

    belongs_to :ticket, class_name: "AttendanceTicket", foreign_key: :ticket_id
  end
end