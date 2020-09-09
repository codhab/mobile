module Candidate
  class EnterprisesController < ApplicationController
    
    def new
      enterprise = ::Candidate::Enterprise.new
      
      enterprise.cadastre_id = current_cadastre.id

      if params[:accept] == 'sim' 
        enterprise.accepted = true 
        #enterprise.save
        
        redirect_to success_path
      else
        enterprise.accepted = false 
        #enterprise.save
        
        redirect_to root_path
      end
    end

  end
end