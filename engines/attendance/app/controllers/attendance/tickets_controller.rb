module Attendance
  class TicketsController < ApplicationController

    def index
      @tickets = current_cadastre.tickets
    end

    def show
      @ticket = Core::Attendance::Ticket.find(params[:id]).presenter
    end

    private

  end
end
