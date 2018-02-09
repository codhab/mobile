require_dependency 'attendance/custom/custom_application_controller'

module Attendance
  module Custom
    class CustomDependentsController < CustomApplicationController
      before_action :set_ticket
      before_action :set_cadastre_mirror
      before_action :set_dependent_mirror, only: [:edit, :update, :destroy]

      def index
        @dependents = @cadastre_mirror.dependent_mirrors
      end

      def new
        @dependent = @cadastre_mirror.dependent_mirrors.new
      end

      def create
        @dependent = @cadastre_mirror.dependent_mirrors.new(set_params)

        if @dependent.save
          redirect_to "#"
        else
          render action: :new
        end
      end

      def edit; end

      def update
        if @dependent.update(set_params)
          redirect_to "#"
        else
          render action: :new
        end
      end

      def destroy
        @dependent.destroy

        redirect_to action: :index
      end

      private

      def set_params
        params.require(:path).permit(:name)
      end

      def set_ticket
        @ticket = Attendance::CustomTicket.find(params[:custom_ticket_id])
      end

      def set_cadastre_mirror
        @cadastre_mirror = @ticket.cadastre_mirror
      end

      def set_dependent_mirror
        @dependent = @cadastre_mirror.dependent_mirrors.find(params[:id])
      end
    end
  end
end
