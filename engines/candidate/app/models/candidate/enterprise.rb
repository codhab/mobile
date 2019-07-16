module Candidate
  class Enterprise
    include ActiveModel::Model 

    attr_accessor :cadastre_id, :acept_id

    validates :cadastre_id, presence: true

    def save
      if valid?
        if acept_id == "1"
          enterprise_cadastre = Core::Candidate::EnterpriseCadastre.new(

            cadastre_id: self.cadastre_id,
            enterprise_id: 22,
            indication_type_id: 1,
            indication_situation_id: 1,
            manifestation_date: Time.now,
            accepted: true,
            accepted_date: Time.now,
            inactive: false

          )
          enterprise_cadastre.save
        else
          enterprise_cadastre = Core::Candidate::EnterpriseCadastre.new(

            cadastre_id: self.cadastre_id,
            enterprise_id: 22,
            indication_type_id: 55,
            manifestation_date: Time.now,
            accepted: false,
            accepted_date: Time.now,
            inactive: true,
            inactive_at: Time.now

          )
        
          enterprise_cadastre.save
        end
      else
        false
      end
    end

  end
end
