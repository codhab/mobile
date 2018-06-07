module Healty
  class Check < ActiveRecord::Base
    self.table_name = 'extranet.address_checks'

    attr_accessor :lat_lng, :password_confirmation

    before_validation :set_lat_lng

    validates :cpf, cpf: true, presence: true
    validates :name, :born, :telephone, presence: true
    validates :password, :password_confirmation, length: {minimum: 8, maximum: 26}, presence: true, on: :create
    validate  :equal_passwords, on: :create

    private

    def equal_passwords
      if !(self.password == self.password_confirmation)
        errors.add(:password, "Senhas não são iguais")
      end
    end

    def set_lat_lng
      if !self.lat_lng.blank?
        lat_lng_split = self.lat_lng.to_s.split('/')
        self.lat = lat_lng_split[0] rescue ''
        self.lng = lat_lng_split[1] rescue ''
      end
    end
  end
end
