require_dependency 'attendance/custom_dependent_mirror'
require_dependency 'attendance/custom_cadastre'

module Attendance
  class CustomCadastreMirror < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_cadastre_mirrors'

    belongs_to :cadastre, class_name: 'Attendance::CustomCadastre', foreign_key: :cadastre_id
    has_many :dependent_mirrors, class_name: 'Attendance::CustomDependentMirror', foreign_key: :cadastre_mirror_id

    validates :born, :born_uf, :place_birth, :gender, :civil_state_id, presence: true
    validates :rg, :rg_org, :rg_uf, :arrival_df, :adapted_property, :mother_name, presence: true
    validates :cid, presence: true, if: 'self.special_condition_id == 2'
  end
end
