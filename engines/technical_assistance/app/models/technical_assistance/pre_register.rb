module TechnicalAssistance
  class PreRegister < ApplicationRecord
    self.table_name = 'generic.social_work_candidate_schedules'
    belongs_to :city,          required: false, class_name: 'Core::Address::City'
    validates :address, :name, presence: true
    validates :cpf, cpf: true, presence: true

    before_save :set_order

    def set_order
      new_order = TechnicalAssistance::PreRegister.where(city_id: self.city_id).order(created_at: :asc).last.order
      self.order = new_order.present? ? new_order + 1 : 1
    end
  end
end
