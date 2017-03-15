require_dependency 'attendance/handle_income/dependent_mirror_model'

class CandidateCadastreMirror < ApplicationRecord
  self.table_name = 'extranet.candidate_cadastre_mirrors'

  has_many :dependent_mirrors, 
    class_name: "CandidateDependentMirror",
    foreign_key: :cadastre_mirror_id

  has_many :income_dependet_mirrors,
    class_name: "Attendance::HandleIncome::DependentMirrorModel",
    foreign_key: :cadastre_mirror_id

  accepts_nested_attributes_for :income_dependet_mirrors,  allow_destroy: true   
  accepts_nested_attributes_for :dependent_mirrors,  allow_destroy: true   
  
  belongs_to :special_condition, class_name: "CandidateSpecialCondition"
  belongs_to :special_condition_type, class_name: "CandidateSpecialConditionType"
  belongs_to :civil_state, class_name: "CandidateCivilState"

  enum gender: ['N/D', 'masculino', 'feminino']
end
