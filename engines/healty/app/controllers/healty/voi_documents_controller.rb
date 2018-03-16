require_dependency 'healty/application_controller'

module Healty
  class VoiDocumentsController < ApplicationController # :nodoc:
    before_action :set_voi
    before_action :set_vois, only: %i[create update destroy]
    before_action :set_voi_document, only: %i[edit update destroy]

    def index
      @voi_document = Core::Healty::VoiDocument.new
    end

    def create
      @voi_document = Core::Healty::VoiDocument.new(set_params)
      @voi_document.name = @voi_document.attachment.file.filename
      @voi_document.voi_id = @voi.id
      @voi_document.staff_id = session[:staff_id]
      @voi_document.save
      redirect_to voi_documents_path(@voi)
    end

    def edit; end

    def update
      @voi_document.update(set_params)
    end

    def destroy
      @voi_document.destroy
    end

    private

    def set_params
      params.require(:voi_document).permit(:name, :attachment)
    end

    def set_vois
      @vois = Core::Healty::Voi.all
    end

    def set_voi
      @voi = Core::Healty::Voi.find(params[:voi_id])
      @voi_documents = @voi.voi_documents.all
    end

    def set_voi_document
      @voi_document = Core::Healty::VoiDocument.find(params[:id])
    end
  end
end
