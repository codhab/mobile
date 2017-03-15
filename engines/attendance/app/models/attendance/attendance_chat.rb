module Attendance
  class AttendanceChat < ApplicationRecord
    self.table_name = 'extranet.attendance_chats'

    belongs_to :chat_category, class_name: "AttendanceChatCategory"
    
    has_many :chat_comments, class_name: "AttendanceChatComment", foreign_key: :chat_id
  end
end
