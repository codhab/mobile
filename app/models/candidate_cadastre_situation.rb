class CandidateCadastreSituation < ApplicationRecord
  self.table_name = 'extranet.candidate_cadastre_situations'

  belongs_to :situation_status, class_name: 'CandidateCadastreSituationStatus',  foreign_key: :situation_status_id
end
