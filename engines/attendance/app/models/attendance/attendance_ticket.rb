module Attendance
  class AttendanceTicket < ApplicationRecord
    self.table_name = 'extranet.attendance_tickets'

    belongs_to :cadastre_mirror, class_name: "CandidateCadastreMirror", foreign_key: :cadastre_mirror_id

    has_many :rg_uploads,         class_name: "AttendanceTicketUpload", foreign_key: :ticket_id
    has_many :cpf_uploads,        class_name: "AttendanceTicketUpload", foreign_key: :ticket_id
    has_many :residence_uploads,  class_name: "AttendanceTicketUpload", foreign_key: :ticket_id


    accepts_nested_attributes_for :rg_uploads,        allow_destroy: true
    accepts_nested_attributes_for :cpf_uploads,       allow_destroy: true
    accepts_nested_attributes_for :residence_uploads, allow_destroy: true
    
  end
end