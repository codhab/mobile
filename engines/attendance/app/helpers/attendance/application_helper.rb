module Attendance
  module ApplicationHelper
    def link_to_add_fields(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
      end
      link_to("<i class='plus icon'></i> Adicionar arquivo".html_safe, '#', class: "add_fields ui disabled button blue fluid icon mini", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def link_to_add_upload_fields(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render('document_fields', f: builder)
      end
      link_to("<i class='plus icon'></i> Adicionar arquivo".html_safe, '#', class: "add_fields ui disabled button blue fluid icon mini", data: {id: id, fields: fields.gsub("\n", "")})
    end
  end
end
