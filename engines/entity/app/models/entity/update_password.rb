module Entity
  class UpdatePassword
    include ActiveModel::Model
    
    attr_accessor :entity, :token, :password, :password_confirmation

    validates :token, :password, :password_confirmation, presence: true
    validates :password, :password_confirmation, length: { minimum: 6, maximum: 18 }

    validate  :password_equal
    validate  :token_is_valid?

    def reset!
      self.entity.update(password: self.password, reset_token: nil)
    end


    private

    def token_is_valid?
      self.entity = Core::Entity::Cadastre.find_by(reset_token: self.token) rescue nil

      if self.entity.nil?
        errors.add(:token, "Código incorreto, favor verificar ou gerar um novo")
      end
    end

    def password_equal
      if self.password != self.password_confirmation
        errors.add(:password, "As senhas não são iguais")
      end
    end

  end
end 