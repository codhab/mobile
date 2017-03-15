require_dependency 'attendance/candidate_cadastre'

module Attendance
  module HandleContact
    class CadastreModel < Attendance::CandidateCadastre

      validates_presence_of :email,
                            :telephone,
                            :address,
                            :cep,
                            :state

      validates :email, email: true

      def cep=(value)
        self[:cep] = value.to_s.gsub('-', '')
      end

      def telephone=(value)
        self[:telephone] = remove_phone_mask(value)
      end

      def telephone_optional=(value)
        self[:telephone_optional] = remove_phone_mask(value)
      end

      def celphone=(value)
        self[:celphone] = remove_phone_mask(value)
      end
      
      private

      def remove_phone_mask value
        value.gsub('-','').gsub(')','').gsub('(','')
      end
    end  
  end
end