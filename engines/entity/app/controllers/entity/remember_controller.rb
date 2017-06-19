require_dependency 'entity/application_controller'

module Entity
  class RememberController < ApplicationController


    def new
      @remember = Entity::Remember.new
    end

    def create
      @remember = Entity::Remember.new(set_params)
      if @remember.valid?
        @remember.recovery!
      else
        render action: :new
      end
    end

    def edit
      @password = Entity::UpdatePassword.new
    end

    def update
      @password = Entity::UpdatePassword.new(set_password_params)
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