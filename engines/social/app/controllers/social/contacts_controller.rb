require_dependency 'social/application_controller'

module Social
  class ContactsController < ApplicationController

    def edit
      @social = current_social
    end

    def update
      @social = current_social

      if @social.update(set_params)
        flash[:success] = "Dados atualizados com sucesso!"
        redirect_to action: :edit
      else
        render action: :edit
      end

    end

    private

    def set_params
      params.require(:social_cadastre).permit(:telephone_optional, :telephone, :celphone, :email)
    end

  end
end
