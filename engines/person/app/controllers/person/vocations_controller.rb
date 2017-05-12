module Person
  class VocationsController < ApplicationController

    def index
      @staff = Core::Person::Staff.find(session[:staff_id])
      @vocations = @staff.vocations
    end

  end
end
