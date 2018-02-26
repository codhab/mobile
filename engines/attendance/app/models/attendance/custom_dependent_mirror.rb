require_dependency 'attendance/custom_cadastre_mirror'

module Attendance
  class CustomDependentMirror < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_dependent_mirrors'

    belongs_to :cadastre_mirror, class_name: 'Attendance::CustomCadastreMirror', foreign_key: :cadastre_mirror_id
    belongs_to :kinship, class_name: 'Core::Candidate::Kinship', foreign_key: :kinship_id

    validates :name, :born, :special_condition_id, presence: true
    validates :special_condition_type_id, :cid, presence: true, if: 'self.special_condition_id == 1'
    validates :cpf, cpf: true, presence: true, if: :is_major?
    validates :rg, :rg_org, presence: true, if: :is_major_super?

    enum gender: ['N/D', 'masculino', 'feminino']

    validate  :age_is_valid?

    def age
      ((Date.today - self.born).to_i / 365.25).to_i rescue I18n.t(:no_information)
    end

    private

    def is_major?
      (self.age >= 14)
    rescue
      false
    end

    def is_major_super?
      (self.age >= 18)
    rescue
      false
    end

    def age_is_valid?
      if (self.age.to_i >= 24) && [3,2].include?(self.kinship_id)
        errors.add(:born, 'Não é possível adicionar dependente (Filho/Enteado ou Irmão/Neto/Bisneto) maior ou igual a 24 anos')
      end
    end
  end
end
