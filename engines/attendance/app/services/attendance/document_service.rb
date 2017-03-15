module Attendance
  class DocumentService

    DOCUMENTS = %w(rg cpf residence arrival_df registry payment income)

    attr_accessor :cadastre, :cadastre_mirror, :ticket, :context_id, :dependent_mirror_id

    def initialize(cadastre: nil, context_id: nil, cadastre_mirror: nil, ticket: nil, target_model: nil, dependent_mirror_id: nil)
      @cadastre            = cadastre
      @context_id          = context_id.to_i
      @cadastre_mirror     = cadastre_mirror
      @ticket              = ticket
      @target_model        = target_model
      @dependent_mirror_id = dependent_mirror_id
    end

    # 1: rg
    # 2: cpf
    # 3: residence
    # 4: arrival_df
    # 5: registry
    # 6: payment

    def document_required
      
      case @context_id
      when 1
        if (@cadastre.main_income != @cadastre_mirror.main_income) || @cadastre.current_situation_id == 3
          @ticket.income_uploads.new
        end

        if (@cadastre.rg != @cadastre_mirror.rg) ||
           (@cadastre.born != @cadastre_mirror.born) ||
           @cadastre.current_situation_id == 3

          @ticket.rg_uploads.new
        end

        if @cadastre.current_situation_id == 3 ||
          @cadastre.arrival_df != @cadastre_mirror.arrival_df
          @ticket.arrival_df_uploads.new 
        end 
 
        if @cadastre.current_situation_id == 3
          @cadastre.payment_uploads.new 
        end

        if @cadastre.current_situation_id == 3
          @ticket.residence_uploads.new
        end
        
        if @cadastre.current_situation_id == 3
          @ticket.registry_uploads.new
        end

        if ((@cadastre.special_condition_id != @cadastre_mirror.special_condition_id) &&
            @cadastre_mirror.special_condition_id == 2) ||
            (@cadastre.current_situation_id == 3 && @cadastre_mirror.special_condition_id == 2)
            @ticket.special_condition_uploads.new
        end 

      when 2
        @dependent = @ticket.cadastre_mirror.dependent_mirrors.find(@dependent_mirror_id)
        
        if @dependent.income.to_i != 0
          @ticket.income_uploads.new
        end

        if @dependent.is_major? 
          @ticket.cpf_uploads.new
        end

        @ticket.certificate_born_uploads.new
        
        if @dependent.special_condition_id == 2
          @ticket.special_condition_uploads.new
        end

      when 3
        @ticket.income_uploads.new
      end
      

=begin

      if (@cadastre.rg != @cadastre_mirror.rg) ||
         @context_id == 2 || @cadastre.current_situation_id == 3

        @ticket.rg_uploads.new                
      end

      if @cadastre.current_situation_id == 3 ||
         @context_id == 2
        @ticket.cpf_uploads.new               
      end 

      if (@cadastre.current_situation_id == 3 && @context_id == 1) 
        @ticket.residence_uploads.new         
      end 

      if @cadastre.arrival_df != @cadastre_mirror.arrival_df ||
        (@cadastre.current_situation_id == 3 && @context_id == 1)
        @ticket.arrival_df_uploads.new        
      end 

      if (@cadastre.current_situation_id == 3 && @context_id == 1)
        @ticket.registry_uploads.new          
      end 

      if (@cadastre.current_situation_id == 3 && @context_id == 1)
        @ticket.payment_uploads.new           
      end

      if (@cadastre.current_situation_id == 3 || @context_id == 2)
        @ticket.certificate_born_uploads.new
      end
=end
      return @ticket
    end

    def is_required? field
      @ticket.send(field).present?
    end

    def nothing_required?
      
      DOCUMENTS.each do |doc|
        return false if @ticket.send("#{doc}_uploads").present?
      end

      return true
    end
    
  end
end