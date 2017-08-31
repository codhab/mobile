require_dependency 'social/application_controller'

module Social
  class RememberController < ApplicationController


    def new
      @remember = Social::Remember.new
    end

    def create
      @remember = Social::Remember.new(set_params)
      if @remember.valid?
        @remember.recovery!
      else
        render action: :new
      end
    end

    def edit
      @password = Social::UpdatePassword.new
    end

    def update
      @password = Social::UpdatePassword.new(set_password_params)
      if @password.valid?
        @password.reset!
      else
        render action: :edit
      end
    end


    private

    def set_params
      params.require(:remember).permit(:cnpj)
    end

    def set_password_params
      params.require(:update_password).permit(:token, :password, :password_confirmation)
    end

  end
end
