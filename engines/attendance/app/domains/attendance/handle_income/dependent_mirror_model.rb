require_dependency 'attendance/candidate_dependent_mirror'

module Attendance
  module HandleIncome
    class DependentMirrorModel < Attendance::CandidateDependentMirror

      def income
        "%.2f" % self[:income]
      end
     
    end
  end
end
