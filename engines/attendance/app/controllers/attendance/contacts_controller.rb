require_dependency 'attendance/handle_contact/cadastre_model'

module Attendance
  class ContactsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 


    def edit
      @cadastre = CoreAttendance::Candidate::Contact.find(@ticket.cadastre_id)
    end

    def update
      @cadastre = CoreAttendance::Candidate::Contact.find(@ticket.cadastre_id)
      
      if @cadastre.update(set_params)
        @ticket.update(ticket_status_id: 2, status: false)

        flash[:title]      = "Operação realizada com sucesso!"
        flash[:message]    = "Os seus dados de contato foram atualizados com sucesso!"
        flash[:html_class] = "success"

        redirect_to ticket_path(@ticket)
      end
    end
    
    private

    def set_params
      params.require(:candidate_contact).permit(:telephone, :telephone_optional, :celphone, 
                                                            :email, :address, :city_id, :state_id, :cep)
    end

    def set_ticket
      @ticket = @cadastre.tickets.find(params[:ticket_id])
    end


    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end
    