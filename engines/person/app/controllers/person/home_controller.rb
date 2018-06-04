require_dependency 'person/application_controller'
module Person
  class HomeController < ApplicationController

    def show
      @staff = Core::Person::Staff.find(session[:staff_id])
      @staff = Core::Person::StaffPresenter.new(@staff)
      @panic = Person::Panic.where(staff_id: current_user.id).last
    end

  end
end
