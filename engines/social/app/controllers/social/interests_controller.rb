require_dependency 'social/application_controller'

module Social
  class InterestsController < ApplicationController
    before_action :set_address, only: [:new, :create]

    def index
    end

    def new
      @interest = Core::Social::InterestForm.where(social_id: current_social.id).new
    end

    def create
      @interest = Core::Social::InterestForm.where(social_id: current_social.id).new(set_params)

      if @interest.save
        redirect_to social_interest_path(@interest)
      else
        flash[:error] = t :error
        render action: :new
      end

    end

    def show
      @interest = current_social.interests.find(params[:id])
    end


    private

    def set_params
      params.fetch(:social_interest_form, {}).permit(unit_sale_ids: [])
    end


    def set_address
      @addresses = Core::Social::UnitSale.where(status: true)
    end

  end
end
