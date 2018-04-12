require_dependency 'regularization/application_controller'

module Regularization
  class SolicitationDocumentsController < ApplicationController # :nodoc:
    before_action :set_solicitation
    before_action :set_solicitation_document, only: [:edit, :update, :destroy]

    def index

    end

    def new
      @solicitation_document = @solicitation.solicitation_documents.new
    end


    def create
      @solicitation_document = @solicitation.solicitation_documents.new(set_params)
      if @solicitation_document.save
      else
        render :new
      end
    end

    def update
      @solicitation_document.update(set_params)
    end

    def show; end


    private

    def set_params
      params.require(:solicitation_document).permit(:solicitation_id, :attachment)
    end

    #  def set_unit
    #   @unit = Core::Address::Unit.find(params[:unit_id])
    # end

    def set_solicitation
      @solicitation = Core::Regularization::Solicitation.find(params[:solicitation_id])
    end

    def set_solicitation_document
      @solicitation_document = Core::Regularization::SolicitationDocument.find(params[:id])
    end

  end
end
