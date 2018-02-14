require_dependency 'attendance/custom_cadastre_mirror'

module Attendance
  class CustomDependentIncome < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_dependent_mirrors'

    validates :income, presence: true
  end
end
