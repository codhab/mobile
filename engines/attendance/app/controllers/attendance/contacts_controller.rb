module Attendance
  class ContactsController < ApplicationController
    
    before_action :set_cadastre
    before_action :set_ticket 


    def edit
    end

    def update
    end
    
    private

    def set_ticket
      @ticket = @cadastre.attendance_tickets.find(params[:ticket_id])
    end


    def set_cadastre
      @cadastre = current_cadastre
    end

  end
end
    