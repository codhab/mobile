require_dependency 'healty/application_controller'

module Healty
  class SealingDocumentsController < ApplicationController # :nodoc:
    before_action :set_sealing

    def index
      @documents = @address.documents.all
      @document  = Core::Healty::SealingDocument.new
    end

    def create
      @document = Core::Healty::SealingDocument.new(set_params)
      @document.name = @document.attachment.file.filename
      @document.address_id = @address.id
      @document.staff_id = session[:staff_id]
      if @document.save
        redirect_to sealing_address_sealing_documents_path(@address)
      else
        render :new
      end
    end

    private

    def set_params
      params.require(:sealing_document).permit(:name, :attachment)
    end

    def set_sealing
      @address = Core::Healty::SealingAddress.find(params[:sealing_address_id])
    end
  end
end
