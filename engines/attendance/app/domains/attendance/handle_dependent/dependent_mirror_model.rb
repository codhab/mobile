require_dependency 'attendance/candidate_dependent_mirror'

module Attendance
  module HandleDependent
    class DependentMirrorModel < Attendance::CandidateDependentMirror

      validates_presence_of :name,
                            :born,
                            :gender,
                            :place_birth,
                            :civil_state_id,
                            :income,
                            :kinship,
                            :special_condition_id

    end
  end
end
