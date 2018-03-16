module Attendance
  class SeiService

    attr_accessor :custom_ticket_id, :cadastre_mirror, :cadastre

    def initialize(custom_ticket_id)
      @custom_ticket_id = custom_ticket_id
    end

    def generate
      @cadastre_mirror = custom_ticket.cadastre_mirror
      @cadastre        = custom_ticket.cadastre
      
    end

    private

    def custom_ticket
      Attendance::Custom::CustomTicket.find(@custom_ticket_id)
    rescue StandarError => e
      raise 'Ticket não encontrado'
    end
  end
end
