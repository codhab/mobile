module Person
  class HomeController < ApplicationController

    def show
      @staff = Core::Person::Staff.find(session[:staff_id])
      @staff = Core::Person::StaffPresenter.new(@staff)
    end

  end
end
