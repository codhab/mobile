class CandidateCadastre < ApplicationRecord
  self.table_name = 'extranet.candidate_cadastres'

  has_many :cadastre_situations, class_name: "CandidateCadastreSituation", foreign_key: :cadastre_id
  has_many :cadastre_mirrors,    class_name: "CandidateCadastreMirror", foreign_key: :cadastre_id 
  has_many :dependents,          class_name: "CandidateDependent", foreign_key: :cadastre_id
  
  has_many :attendance_notifications, class_name: "Attendance::AttendanceNotification", foreign_key: :cadastre_id
  
  belongs_to :special_condition, class_name: "CandidateSpecialCondition", foreign_key: :cadastre_id
  belongs_to :special_condition_type, class_name: "CandidateSpecialConditionType", foreign_key: :cadastre_id
  belongs_to :state, class_name: "AddressState", foreign_key: :state_id
  belongs_to :city,  class_name: "AddressCity",  foreign_key: :city_id

  has_many :attendance_tickets,  class_name: "Attendance::AttendanceTicket", foreign_key: :cadastre_id

  enum gender: ['N/D', 'masculino', 'feminino']
end
