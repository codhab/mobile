module Attendance
  class AttendanceTicket < ApplicationRecord
    self.table_name = 'extranet.attendance_tickets'

    belongs_to :cadastre_mirror, class_name: "CandidateCadastreMirror", foreign_key: :cadastre_mirror_id

    has_many :rg_uploads, 
        -> { where(update_category_id: 1) },
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    has_many :cpf_uploads,
        -> { where(update_category_id: 2) },
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    has_many :residence_uploads,  
        -> { where(update_category_id: 3)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id
   
    has_many :arrival_df_uploads,
        -> { where(update_category_id: 4)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id
    
    has_many :registry_uploads,
        -> { where(update_category_id: 5)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id
    
    has_many :certificate_born_uploads,
        -> { where(update_category_id: 6)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    accepts_nested_attributes_for :rg_uploads,                 allow_destroy: true
    accepts_nested_attributes_for :cpf_uploads,                allow_destroy: true
    accepts_nested_attributes_for :residence_uploads,          allow_destroy: true
    accepts_nested_attributes_for :arrival_df_uploads,         allow_destroy: true
    accepts_nested_attributes_for :registry_uploads,           allow_destroy: true
    accepts_nested_attributes_for :certificate_born_uploads,   allow_destroy: true
    
  end
end