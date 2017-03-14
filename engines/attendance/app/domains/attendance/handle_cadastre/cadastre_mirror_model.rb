require_dependency 'attendance/candidate_cadastre_mirror'

module Attendance
  module HandleCadastre
    class CadastreMirrorModel < Attendance::CandidateCadastreMirror

      attribute :rg, :string

      validates :rg, presence: true
    end  
  end
end