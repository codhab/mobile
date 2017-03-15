require_dependency 'attendance/candidate_cadastre_mirror'

module Attendance
  module HandleCadastre
    class CadastreMirrorModel < Attendance::CandidateCadastreMirror

      attribute :rg, :string

      validates_presence_of :rg,
                            :rg_org,
                            :gender,
                            :born_uf,
                            :rg_uf,
                            :place_birth,
                            :special_condition

      validates :special_condition_type, presence: true, if: 'special_condition_id == 2'
      validates :cid, presence: true, if: 'special_condition_id == 2'
    end  
  end
end