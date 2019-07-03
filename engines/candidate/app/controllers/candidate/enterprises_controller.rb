module Candidate
  class EnterprisesController < ApplicationController
    
    def new
      enterprise = Candidate::Enterprise.new
      
      enterprise.cadastre_id = current_cadastre.id
      enterprise.acept_id = params[:acept_id]

        if enterprise.save
          if enterprise.acept_id == "1"
            redirect_to success_path
          else
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
    end

  end
end