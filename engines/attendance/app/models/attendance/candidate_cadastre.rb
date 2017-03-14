module Attendance
  class CandidateCadastre < ::CandidateCadastre
    has_many :attendance_tickets,  foreign_key: :cadastre_id
  end
end
