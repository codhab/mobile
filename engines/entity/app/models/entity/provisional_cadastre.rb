module Entity
  class ProvisionalCadastre
    include ActiveModel::Model 

    attr_accessor :name, :cpf, :born, :entity_id, :enterprise_id

    validates :name, :born, presence: true
    validates :cpf, cpf: true, presence: true

    validate :unique_cpf

    def save
      if valid?
        cadastre = Core::Candidate::Cadastre.new({
          cpf: self.cpf,
          name: self.name,
          born: self.born,
          program_id: 1
        })

        cadastre.save

        
        situation = cadastre.cadastre_situations.new({
          situation_status_id: 69,
          observation: "Inscrição eventual feita por Entidade"
        })
      
        situation.save

        
        candidate_associate = Entity::ProvisionalCandidate.new({
          entity_id: self.entity_id,
          candidate_id: cadastre.id
        })

        candidate_associate.save

        
        enterprise = cadastre.enterprise_cadastres({
          enterprise_id: self.enterprise_id,
          inactive: false
        })

        enterprise.save

        true
      else
        false 
      end
    end

    private 

    def unique_cpf
      candidate = Core::Candidate::Cadastre.find_by(cpf: self.cpf) rescue nil
      
      if !candidate.nil?
        errors.add(:cpf, "CPF já possui cadastro na CODHAB")
      end
      
    end


  end
end