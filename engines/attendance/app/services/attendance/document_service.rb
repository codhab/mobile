module Attendance
  class DocumentService

    DOCUMENTS = %w(rg cpf residence arrival_df registry payment)

    attr_accessor :cadastre, :cadastre_mirror, :ticket, :context_id

    def initialize(cadastre: nil, context_id: nil, cadastre_mirror: nil, ticket: nil)
      @cadastre        = cadastre
      @context_id      = context_id.to_i
      @cadastre_mirror = cadastre_mirror
      @ticket          = ticket
    end

    # 1: rg
    # 2: cpf
    # 3: residence
    # 4: arrival_df
    # 5: registry
    # 6: payment

    def document_required

      @ticket.rg_uploads.new                if @cadastre.rg != @cadastre_mirror.rg
      @ticket.cpf_uploads.new               if @cadastre.current_situation_id == 3
      @ticket.residence_uploads.new         if @cadastre.current_situation_id == 3
      @ticket.arrival_df_uploads.new        if @cadastre.arrival_df != @cadastre_mirror.arrival_df
      @ticket.registry_uploads.new          if @cadastre.current_situation_id == 3
      @ticket.payment_uploads.new           if @cadastre.current_situation_id == 3

      return @ticket
    end

    def is_required? field
      return true
      @ticket.send(field).present?
    end

    def nothing_required?
      return false
      DOCUMENTS.each do |doc|
        return false if @ticket.send("#{doc}_uploads").present?
      end

      return true
    end
    
  end
end