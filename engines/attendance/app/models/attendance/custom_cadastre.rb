require_dependency 'attendance/custom_cadastre_mirror'

module Attendance
  class CustomCadastre < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_cadastres'

    has_many :cadastre_mirrors, class_name: 'Attendance::CustomCadastreMirror', foreign_key: :cadastre_id
    has_many :dependents, class_name: 'Attendance::CustomDependent', foreign_key: :cadastre_id
  end
end
