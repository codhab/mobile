require_dependency 'attendance/handle_contact/cadastre_model'

module Attendance
  class ContactsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 


    def edit
      @cadastre = Attendance::HandleContact::CadastreModel.find @ticket.cadastre_id
    end

    def update
      @cadastre = Attendance::HandleContact::CadastreModel.find @ticket.cadastre_id
      if @cadastre.update(set_params)
        @ticket.update(ticket_status_id: 2)
        redirect_to ticket_path(@ticket)
      end
    end
    
    private

    def set_params
      params.require(:handle_contact_cadastre_model).permit(:telephone, :telephone_optional, :celphone, 
                                                            :email, :address, :city_id, :state_id, :cep)
    end

    def set_ticket
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end


    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end
    