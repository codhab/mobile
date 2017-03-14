module Attendance
  class CandidateCadastreSituation < ApplicationRecord
    self.table_name = 'extranet.candidate_cadastre_situations'

    belongs_to :situation_status, class_name: 'CandidateCadastreSituationStatus'
  end
end
