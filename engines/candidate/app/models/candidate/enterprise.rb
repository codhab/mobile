module Candidate
  class Enterprise
    include ActiveModel::Model 

    attr_accessor :cadastre_id, :accepted

    validates :cadastre_id, presence: true

    def save
      if valid?
        if accepted
          enterprise_cadastre = Core::Candidate::EnterpriseCadastre.new(
            cadastre_id: self.cadastre_id,
            enterprise_id: 182,
            indication_type_id: 999,
            manifestation_date: Time.current,
            accepted: true,
            accepted_date: Time.current,
            inactive: false
          )
          enterprise_cadastre.save(validate: false)

        else
          enterprise_cadastre = Core::Candidate::EnterpriseCadastre.new(
            cadastre_id: self.cadastre_id,
            enterprise_id: 182,
            indication_type_id: 999,
            manifestation_date: Time.current,
            accepted: false,
            accepted_date: Time.current,
            inactive: true,
            inactive_at: Time.current
          )
          enterprise_cadastre.save(validate: false)
        end

      else
        false
      end
    end

  end
end
