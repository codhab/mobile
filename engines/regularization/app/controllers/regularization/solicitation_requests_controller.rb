require_dependency 'regularization/application_controller'

module Regularization
  class SolicitationRequestsController < ApplicationController # :nodoc:
    before_action :set_solicitation
    before_action :set_requests
    before_action :set_request, only: %i[edit update destroy]

    def index; end

    def new
      @request = @solicitation.solicitation_requests.new
    end

    def create
      @request = @solicitation.solicitation_requests.new(set_params)
      if @request.save
        redirect_to new_solicitation_document_path(@solicitation, request_id: @request.id)
      else
        render :new
      end
    end

    def edit; end

    def update
      @request.update(set_params)
    end

    def destroy
      if @request.destroy
        flash[:success] = 'operação realizada com sucesso.'
        render action: :index
      end
    end

    private

    def set_params
      params.require(:solicitation_request).permit(:observation, :status)
    end

    def set_requests
      @requests = @solicitation.solicitation_requests.all
    end

    def set_request
      @request = @solicitation.solicitation_requests.find(params[:id])
    end

    def set_solicitation
      @solicitation = Core::Regularization::Solicitation.find(params[:solicitation_id])
    end

  end
end
