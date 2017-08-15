namespace :migrate do 

  task entity: :environment do 

    Core::Entity::Cadastre.all.each do |entity|
      @entity = entity

      if @entity.interests.present?
        @interest = @entity.interests.new
        @interest.unit_sale_ids = []
        @created_at =""

        @entity.interests.each do |inter|
          @interest.unit_sale_ids << inter.unit_sale_id
          @created_at = inter.created_at if !inter.created_at.nil?
        end

        @interest.created_at = @created_at
        @interest.allotment_id = 1

        @interest.save
      end
    end

  end
end