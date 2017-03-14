class CandidateDependentMirror < ApplicationRecord
  self.table_name = 'extranet.candidate_dependent_mirrors'

  belongs_to :kinship, class_name: 'CandidateKinship'
end
