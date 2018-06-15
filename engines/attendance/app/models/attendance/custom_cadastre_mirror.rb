require_dependency 'attendance/custom_dependent_mirror'
require_dependency 'attendance/custom_cadastre'

module Attendance
  class CustomCadastreMirror < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_cadastre_mirrors'

    has_many :custom_dependent_mirrors, class_name: 'Attendance::CustomDependentMirror', foreign_key: :cadastre_mirror_id

    # Adaptacao para suprir atendimento aos candidatos de realocacao, program_id: 13
    attr_accessor :spouse_name, :spouse_cpf

    belongs_to :cadastre, class_name: 'Attendance::CustomCadastre', foreign_key: :cadastre_id
    has_many :dependent_mirrors, class_name: 'Attendance::CustomDependentMirror', foreign_key: :cadastre_mirror_id

    validates :born, :born_uf, :place_birth, :gender, :civil_state_id, presence: true
    validates :rg, :rg_org, :rg_uf, presence: true
    validates :arrival_df, :adapted_property, :mother_name, presence: true, if: 'self.program_id != 13'
    validates :cid, presence: true, if: 'self.special_condition_id == 2 && self.program_id != 13'
    validates :spouse_name, presence: true, if: '[13].include?(self.program_id) && ([2,7].include?(self.civil_state_id))'
    validates :spouse_cpf, cpf: true, presence: true, if: '[13].include?(self.program_id) && ([2,7].include?(self.civil_state_id))'

    # Adaptacao para suprir atendimento aos candidatos de realocacao, program_id: 13
    after_save :set_dependent, if: '[13].include?(self.program_id) && ([2,7].include?(self.civil_state_id))'

    def spouse_name
      if self.custom_dependent_mirrors.where(kinship_id: 6).present?
        spouse = self.custom_dependent_mirrors.where(kinship_id: 6).last
        @spouse_name = spouse.name
      else
        @spouse_name
      end
    end

    def spouse_cpf
      if self.custom_dependent_mirrors.where(kinship_id: 6).present?
        spouse = self.custom_dependent_mirrors.where(kinship_id: 6).last
        @spouse_cpf = spouse.cpf
      else
        @spouse_cpf
      end
    end

    private

    def set_dependent
      if !self.custom_dependent_mirrors.where(kinship_id: 6).present?
        dependent = self.custom_dependent_mirrors.new({
          name: self.spouse_name,
          cpf: self.spouse_cpf,
          kinship_id: 6
        })
        dependent.save!(validate: false)
      end
    end

  end
end
