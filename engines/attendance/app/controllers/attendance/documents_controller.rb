require_dependency 'attendance/application_controller'

module Attendance
  class DocumentsController < ApplicationController
      
    before_action :set_cadastre
    before_action :set_ticket
    before_action :set_action 


    def new      
      @action   = Core::Attendance::ActionDocumentForm.find(@action.id)
      @action   = Core::Attendance::ActionPolicy.new(@action)
      
      @service  = Core::Attendance::DocumentService.new({cadastre: @cadastre,
                                                         action: @action,
                                                         ticket: @ticket,
                                                         dependent_id: session[:dependent_id]})  
      
      @service.documents_required!

      @action = @service.action
    end

    def create

      if @action.update(set_params)
        
        if @action.context_id == 2
          redirect_to ticket_dependents_path(@ticket)
        elsif @action.context_id == 3
          redirect_to ticket_incomes_path(@ticket)
        else
          @service = Core::Attendance::TicketService.new(cadastre: @cadastre, ticket: @ticket, action: @action)
          @service.close_action

          redirect_to new_ticket_path
        end
      else
        render action: :new
      end

    end

    private

    def set_params
      params.fetch(:attendance_action_document_form, {})
            .permit(
              born_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              certificate_born_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              income_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              rg_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              cpf_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              residence_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              arrival_df_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              registry_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              payment_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              income_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model],
              special_condition_documents_attributes: [:id, :_destroy, :document, :target_id, :target_model]
              )
    end

    def set_cadastre
      @cadastre = current_cadastre
    end

    def set_ticket
      @ticket   = @cadastre.tickets.find(params[:ticket_id]).policy
    end

    def set_action
      @action   = @ticket.actions.find(params[:action_id])
    end
  end
end