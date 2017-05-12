module Person
  class AllowancesController < ApplicationController

    def index
      @staff = Core::Person::Staff.find(session[:staff_id])
      @allowances = @staff.allowances
    end

  end
end
