require_dependency 'attendance/custom_dependent_mirror'
require_dependency 'attendance/custom_cadastre'

module Attendance
  class CustomCadastreIncome < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_cadastre_mirrors'
    has_many :dependent_mirrors, class_name: 'Attendance::CustomDependentMirror', foreign_key: :cadastre_mirror_id

    validates :main_income, presence: true

  end
end
