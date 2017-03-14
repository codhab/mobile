class CandidateCadastreMirror < ApplicationRecord
  self.table_name = 'extranet.candidate_cadastre_mirrors'

  has_many :dependent_mirrors, 
    class_name: "CandidateDependentMirror",
    foreign_key: :cadastre_mirror_id

  belongs_to :special_condition, class_name: "CandidateSpecialCondition"
  belongs_to :special_condition_type, class_name: "CandidateSpecialConditionType"
  
  enum gender: ['N/D', 'masculino', 'feminino']
end
