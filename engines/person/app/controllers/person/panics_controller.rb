require_dependency 'person/application_controller'
module Person
	class PanicsController < ApplicationController

		before_action :set_panics, only: [:index, :create, :destroy, :panic_stop]
		before_action :set_panic, only: [:edit, :destroy, :update]

		def new
			@panic = Panic.new
		end

		def create
			@panic = Panic.new(panic_params)
			@panic.panic = true
			@panic.staff_id = current_user.id
			if @panic.save
			  Person::PanicMailer.panic_solicitation(@panic).deliver_now!
				@panic.push
			end
		end

		def panic_stop
			@panic = Person::Panic.find(params[:id])
			@panic.panic = false
			@panic.save
		end

		def destroy
		  @panic.destroy
		end

	private

		def panic_params
			params.require(:panic).permit(:station_id, :satff_id, :description, :panic)
		end

		def set_panic
			@panic = Panic.find(params[:id])
		end

		def set_panics
			@panics = apply_scopes(Panic).all
		end
	end
end
