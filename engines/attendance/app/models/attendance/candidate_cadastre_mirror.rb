module Attendance
  class CandidateCadastreMirror < ApplicationRecord
    self.table_name = 'extranet.candidate_cadastre_mirrors'

    has_many :dependent_mirrors, class_name: "CandidateDependentMirror", foreign_key: :cadastre_mirror_id
  end
end
