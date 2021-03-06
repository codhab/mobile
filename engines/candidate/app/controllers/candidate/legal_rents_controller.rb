require_dependency 'candidate/application_controller'

module Candidate
  class LegalRentsController < ApplicationController

    def new

      if !Candidate::LegalRent.where(cadastre_id: current_cadastre.id).present?

        if params[:status] == 'true'

          respond_to do |format|
            format.js {
              
            }

            format.html {
              @rent = Candidate::LegalRent.new(cadastre_id: current_cadastre.id)
              @rent.status = true
              @rent.save
            }
          end
        end

        if params[:status] == 'false'
          @rent = Candidate::LegalRent.new(cadastre_id: current_cadastre.id)
          @rent.status = false
          @rent.save
        end

      end

    end

  end
end
