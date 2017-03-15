require_dependency 'attendance/candidate_dependent_mirror'

module Attendance
  module HandleDependent
    class DependentMirrorModel < Attendance::CandidateDependentMirror

      validates_presence_of :name,
                            :born,
                            :gender,
                            :place_birth,
                            :civil_state_id,
                            :income,
                            :kinship,
                            :special_condition_id

      validates :cpf, cpf: true, presence: true, if: :is_major?
      validates_uniqueness_of :cpf, scope: :cadastre_mirror_id

      validates :name, presence: true
      validates :cid, presence: true, if: 'self.special_condition_id == 2'

      validate :spouse_present?

      private

      def spouse_present?
        if self.cadastre_mirror.dependent_mirrors.where(kinship_id: 6).present?
          errors.add(:kinship_id, "Já existe um conjugê cadastrado")
        end
      end

    end
  end
end
