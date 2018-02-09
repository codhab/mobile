require_dependency 'attendance/custom_cadastre_mirror'

module Attendance
  class CustomDependentMirror < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_dependent_mirrors'

    belongs_to :cadastre_mirror, class_name: 'Attendance::CustomCadastreMirror', foreign_key: :cadastre_mirror_id
    belongs_to :kinship, class_name: 'Core::Candidate::Kinship', foreign_key: :kinship_id

    validates :rg, :rg_org, :born, :special_condition_id, presence: true
    validates :special_condition_type_id, :cid, presence: true, if: 'self.special_condition_id == 1'

  end
end
