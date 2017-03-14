class CandidateCadastre < ApplicationRecord
  self.table_name = 'extranet.candidate_cadastres'

  has_many :cadastre_situations, class_name: "CandidateCadastreSituation", foreign_key: :cadastre_id
  has_many :cadastre_mirrors,    class_name: "CandidateCadastreMirror", foreign_key: :cadastre_id 
  has_many :dependents,          class_name: "CandidateDependent", foreign_key: :cadastre_id

end
