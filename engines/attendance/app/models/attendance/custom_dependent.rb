require_dependency 'attendance/custom_cadastre_mirror'

module Attendance
  class CustomDependent < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_dependents'

    belongs_to :cadastre, class_name: 'Attendance::CustomCadastre', foreign_key: :cadastre_id

  end
end
