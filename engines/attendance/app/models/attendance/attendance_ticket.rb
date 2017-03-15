module Attendance
  class AttendanceTicket < ApplicationRecord
    self.table_name = 'extranet.attendance_tickets'

    belongs_to :cadastre,        class_name: "CandidateCadastre",       foreign_key: :cadastre_id
    belongs_to :cadastre_mirror, class_name: "CandidateCadastreMirror", foreign_key: :cadastre_mirror_id
    belongs_to :ticket_status,   class_name: "AttendanceTicketStatus",  foreign_key: :ticket_status_id
    belongs_to :ticket_context,  class_name: "AttendanceTicketContext", foreign_key: :ticket_context_id
    
    has_many   :ticket_comments, class_name: "AttendanceTicketComment", foreign_key: :ticket_id

    has_many :rg_uploads, 
        -> { where(upload_category_id: 1) },
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    has_many :cpf_uploads,
        -> { where(upload_category_id: 2) },
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    has_many :residence_uploads,  
        -> { where(upload_category_id: 3)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id
   
    has_many :arrival_df_uploads,
        -> { where(upload_category_id: 4)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id
    
    has_many :registry_uploads,
        -> { where(upload_category_id: 5)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id
    
    has_many :certificate_born_uploads,
        -> { where(upload_category_id: 6)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    has_many :payment_uploads,
        -> { where(upload_category_id: 7)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id
        

    has_many :income_uploads,
        -> { where(upload_category_id: 8)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    has_many :special_condition_uploads,
        -> { where(upload_category_id: 9)},
        class_name: "AttendanceTicketUpload",
        foreign_key: :ticket_id

    accepts_nested_attributes_for :rg_uploads,                 allow_destroy: true
    accepts_nested_attributes_for :cpf_uploads,                allow_destroy: true
    accepts_nested_attributes_for :residence_uploads,          allow_destroy: true
    accepts_nested_attributes_for :arrival_df_uploads,         allow_destroy: true
    accepts_nested_attributes_for :registry_uploads,           allow_destroy: true
    accepts_nested_attributes_for :certificate_born_uploads,   allow_destroy: true
    accepts_nested_attributes_for :payment_uploads,            allow_destroy: true
    accepts_nested_attributes_for :income_uploads,             allow_destroy: true
    accepts_nested_attributes_for :special_condition_uploads,  allow_destroy: true
    
  end
end