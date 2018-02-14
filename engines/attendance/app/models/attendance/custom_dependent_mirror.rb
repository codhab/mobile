require_dependency 'attendance/custom_cadastre_mirror'

module Attendance
  class CustomDependentMirror < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_dependent_mirrors'

    belongs_to :cadastre_mirror, class_name: 'Attendance::CustomCadastreMirror', foreign_key: :cadastre_mirror_id
    belongs_to :kinship, class_name: 'Core::Candidate::Kinship', foreign_key: :kinship_id

    validates :name, :rg, :rg_org, :born, :special_condition_id, presence: true
    validates :special_condition_type_id, :cid, presence: true, if: 'self.special_condition_id == 1'
    validates :cpf, cpf: true, presence: true, if: :is_major?

    enum gender: ['N/D', 'masculino', 'feminino']

    def age
      ((Date.today - self.born).to_i / 365.25).to_i rescue I18n.t(:no_information)
    end

    private

    def is_major?
      (self.age >= 14)
    rescue
      false
    end
  end
end
