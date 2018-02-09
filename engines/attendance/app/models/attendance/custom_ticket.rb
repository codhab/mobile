module Attendance
  class CustomTicket < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.attendance_custom_tickets'

    belongs_to :cadastre, class_name: 'Attendance::CustomCadastre', foreign_key: :cadastre_id
    belongs_to :cadastre_mirror, class_name: 'Attendance::CustomCadastreMirror', foreign_key: :cadastre_mirror_id

    has_many :documents, class_name: 'Attendance::CustomTicketDocument', foreign_key: :custom_ticket_id

    after_create :set_cadastre_mirror

    validates :cadastre_id, uniqueness: true

    private

    def set_cadastre_mirror
      current_cadastre = self.cadastre
      current_dependents = self.cadastre.dependents

      new_mirror = self.cadastre.cadastre_mirrors.new

      current_cadastre.attributes.each do |key, _value|
        unless %w(id created_at updated_at).include?(key)
          new_mirror[key] = current_cadastre[key] if new_mirror.attributes.has_key?(key)
        end
      end

      new_mirror.save


      current_dependents.each do |dependent|
        new_dependent = new_mirror.dependent_mirrors.new
        dependent.attributes.each do |key, _value|
          unless %w(id created_at updated_at).include?(key)
            new_dependent[key] = dependent[key] if new_dependent.attributes.has_key?(key)
          end
        end
        new_dependent.save
      end

      self.cadastre_mirror_id = new_mirror.id

      save
    end


  end
end
