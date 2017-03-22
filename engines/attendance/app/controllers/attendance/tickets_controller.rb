module Attendance
  class TicketsController < ApplicationController
    before_action :set_cadastre

    def index
      @tickets = current_cadastre.tickets
    end

  end
end