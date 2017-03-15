module Attendance
  class CandidateCadastreMirror < ::CandidateCadastreMirror
    self.table_name = 'extranet.candidate_cadastre_mirrors'

    has_many :dependent_mirrors, class_name: "CandidateDependentMirror", foreign_key: :cadastre_mirror_id
    
    accepts_nested_attributes_for :dependent_mirrors, allow_destroy: false
  end
end
