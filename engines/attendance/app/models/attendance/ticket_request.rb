module Attendance
  class TicketRequest < ActiveRecord::Base
    self.table_name = 'extranet.attendance_custom_ticket_requests'

    belongs_to :custom_ticket, class_name: '::Attendance::CustomTicket', foreign_key: :custom_ticket_id
  end
end
