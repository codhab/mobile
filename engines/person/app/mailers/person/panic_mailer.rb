module Person
  class PanicMailer < ActionMailer::Base
    default from: 'suporte@codhab.df.gov.br'

    def panic_solicitation(panic)
      @panic = Person::Panic.find(panic.id)
      mail(to: 'ana.coelho@codhab.df.gov.br , ana.nardelli@codhab.df.gov.br , antonio.improise@codhab.df.gov.br, Elton.Silva@codhab.df.gov.br, cleuber.canamari@codhab.df.gov.br' , subject: "panico")
    end
  end
end
