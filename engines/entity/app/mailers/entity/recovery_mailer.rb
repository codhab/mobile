module Entity
  class RecoveryMailer < ActionMailer::Base
    default from: 'nao-responda@codhab.df.gov.br'

    def remember(entity, email, token)
      @entity = entity
      @email  = email 
      @token  = token 

      mail(to: @email, subject: "Entidades - Recuperação de senha de acesso")
    end

    def simple(interest, email)
      @interest = interest
      
      mail(to: email, subject: "Manifestação de interesse realizada com sucesso!")
    end

  end
end