module Entity
  module ApplicationHelper
    def link_to_add_fields(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
      end
      link_to("<i class='plus icon'></i> Adicionar arquivo".html_safe, '#', class: "add_fields ui button blue fluid icon mini", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def link_to_add_upload_fields(name, f, association, target_id = nil, target_model = nil, persisted = nil)
      if target_id.nil?
        new_object = f.object.send(association).new
      else 
        new_object = f.object.send(association).where(target_id: target_id, target_model: target_model).new
      end

      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render('document_fields', f: builder)
      end

      class_disabled = persisted ? '' : 'disabled'

      link_to("<i class='plus icon'></i> Adicionar arquivo".html_safe, '#', class: "add_fields ui #{class_disabled} button blue fluid icon mini", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def temp_entity_current_situation(cnpj)
      ::Entity::TempCooperative.find_by(cnpj: cnpj).temp_cooperative_situations.order(created_at: :desc).first.situation.name
    rescue
      'Sem informação'
    end


  end
end
