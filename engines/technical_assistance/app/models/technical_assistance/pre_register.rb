module TechnicalAssistance
  class PreRegister < ApplicationRecord
    self.table_name = 'generic.social_work_candidate_schedules'
    belongs_to :city,          required: false, class_name: 'Core::Address::City'
    validates :address, :name, presence: true
    validates :cpf, cpf: true, presence: true
  end
end
