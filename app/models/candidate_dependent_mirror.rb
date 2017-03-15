class CandidateDependentMirror < ApplicationRecord
  self.table_name = 'extranet.candidate_dependent_mirrors'

  belongs_to :cadastre_mirror, class_name: "CandidateCadastreMirror", foreign_key: 'cadastre_mirror_id'
  belongs_to :kinship, class_name: 'CandidateKinship'
  belongs_to :civil_state, class_name: "CandidateCivilState", foreign_key: 'civil_state_id'
  belongs_to :special_condition, class_name: "CandidateSpecialCondition", foreign_key: 'special_condition_id'

  enum gender: ['N/D', 'masculino', 'feminino']


  def is_major?
    (age >= 14)
  end


  def age
    if self.born.present?
      (Date.current - self.born).to_i / 365
    else 
      0
    end
  end


end
