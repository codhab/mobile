module Attendance
  class DocumentService

    attr_accessor :cadastre, :cadastre_mirror, :ticket, :context_id

    def initialize(cadastre: nil, context_id: nil, cadastre_mirror: nil, ticket: nil)
      @cadastre        = cadastre
      @context_id      = context_id.to_i
      @cadastre_mirror = cadastre_mirror
      @ticket          = ticket
    end


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
      
    end
    
  end
end