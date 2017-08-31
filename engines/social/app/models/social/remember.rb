module Social
  class Remember
    include ActiveModel::Model

    attr_accessor :cnpj, :entity

    validates :cnpj, presence: true, cnpj: true

    validate  :cnpj_is_valid?

    def recovery!
      @email = self.entity.email
      @token = SecureRandom.urlsafe_base64(6, false).downcase

      begin
        Social::RecoveryMailer.remember(@entity, @email, @token).deliver_now!

        self.entity.update(reset_token: @token)

      rescue Exception => e
        puts "error - #{e}"
      end
    end

    private

    def cnpj_is_valid?
      self.entity = Core::Social::Cadastre.find_by(cnpj: self.cnpj) rescue nil

      if self.entity.nil?
        errors.add(:cnpj, "CNPJ não encontrado")
      end

    end

  end
end
