module TechnicalAssistance
  class PreRegister < ApplicationRecord
    self.table_name = 'extranet.technical_assistance_pre_registers'
    belongs_to :city,          required: false, class_name: 'Core::Address::City'
    belongs_to :burgh,         required: false, class_name: 'Core::Address::Burgh', foreign_key: :burgh_id
    validates  :address, :name, :city_id, :phone, :cad, :special_condition, presence: true
    
    validates :cpf, cpf: true, presence: true, uniqueness: true

    #after_commit :set_order

    #def set_order
    #  Core::SocialWork::CandidateSchedule.where(city_id: self.city_id).order(created_at: :asc).each_with_index do |schedule, i|
    #    schedule.order = i + 1
    #    schedule.save(validate: false)
    #  end
    #end
  end
end
