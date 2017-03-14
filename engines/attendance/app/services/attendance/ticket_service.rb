module Attendance
  class TicketService

    # :ticket_status_id 
    # 1: pendente com candidato 
    # 2: finalizado pelo candidato
    # 3: pendente com atendente
    # 4: pendente com supervisor
    # 5: finalizado
    # 6: cancelado 
    # 7: cancelado pelo candidato
      
    # :ticket_context_id
    # 1: atualização cadastral  
    # 2: atualização dependentes   
    # 3: atualização renda   
    # 4: atualização contato

    attr_accessor :cadastre, :cadastre_mirror, :ticket, :context_id

    def initialize(cadastre: nil, context_id: nil, cadastre_mirror: nil, ticket: nil)
      @cadastre        = cadastre
      @context_id      = context_id.to_i
      @cadastre_mirror = cadastre_mirror
      @ticket          = ticket
    end

    def create
     
      return false if !create_ticket?

      create_mirrors!

      @ticket = AttendanceTicket.new({
        ticket_context_id: @context_id,
        ticket_status_id: 1, 
        cadastre_id: @cadastre.id,
        cadastre_mirror_id: @cadastre_mirror.id
      })

      @ticket.save
    end

    def route_path
      return false if @context_id.nil?

      # :ticket_context_id
      # 1: atualização cadastral  
      # 2: atualização dependentes   
      # 3: atualização renda   
      # 4: atualização contato
      
      case @context_id
      when 1
        Attendance::Engine.routes.url_helpers.edit_cadastre_path(ticket_id: @ticket.id)
      when 2
      when 3
      when 4
      end

    end

    private

    def create_ticket?
      return false if @cadastre.nil? || @context_id.nil?

      # :ticket_status_id
      # 1: pendente com candidato
      # 3: pendente com atendente
      # 4: pendente com supervisor

      # cadastre can not contain a ticket with status [1,3,4]
      !@cadastre.attendance_tickets.where(ticket_context_id: @context_id, ticket_status_id: [1, 3, 4]).present?
    end

    def create_mirrors!
      return false if @cadastre.nil?

      @cadastre_mirror = @cadastre.cadastre_mirrors.new

      @cadastre.attributes.each do |key, value|
        unless %w(id created_at updated_at).include? key
          @cadastre_mirror[key] = value if @cadastre_mirror.attributes.has_key?(key)
        end
      end

      @cadastre_mirror.save
    
      @dependents = @cadastre.dependents

      @dependents.each do |dependent|
        @new_dependent = @cadastre_mirror.dependent_mirrors.new
        
        dependent.attributes.each do |key, value|
          unless %w(id created_at updated_at).include? key
            @new_dependent[key] = value if @new_dependent.attributes.has_key?(key)
          end
        end

        @new_dependent.save
    
      end
    end

  end
end