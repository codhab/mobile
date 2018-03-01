module Attendance
  class CustomTicket < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.attendance_custom_tickets'

    belongs_to :cadastre, class_name: 'Attendance::CustomCadastre', foreign_key: :cadastre_id
    belongs_to :cadastre_mirror, class_name: 'Attendance::CustomCadastreMirror', foreign_key: :cadastre_mirror_id

    has_many :documents, class_name: 'Attendance::CustomTicketDocument', foreign_key: :custom_ticket_id

    after_create :set_cadastre_mirror

    validates :cadastre_id, uniqueness: true

    def disable_link
      self.action_one &&
      self.action_two &&
      self.action_three &&
      self.action_four &&
      self.action_five
    end

    def allow_cadastre
      return false if !(self.documents.where(document_type_id: 1).present? && self.documents.where(document_type_id: 2).present? &&
      self.documents.where(document_type_id: 3).present? && self.documents.where(document_type_id: 4).present?)

      if self.cadastre_mirror.special_condition_id == 2
        return false if !self.documents.where(document_type_id: 5).present?
      end

      if self.cadastre_mirror.civil_state_id == 3
        return false if !self.documents.where(document_type_id: 6).present?
      end

      if self.cadastre_mirror.civil_state_id == 1
        return false if !self.documents.where(document_type_id: 7).present?
      end

      if self.cadastre_mirror.civil_state_id == 7
        return false if !self.documents.where(document_type_id: 11).present?
      end

      if self.cadastre_mirror.civil_state_id == 2
        return false if !self.documents.where(document_type_id: 12).present?
      end

      if self.cadastre_mirror.civil_state_id == 4
        return false if !self.documents.where(document_type_id: 12).present?
        return false if !self.documents.where(document_type_id: 13).present?
      end

      return true
    end

    def allow_dependent dependent_id
      dependent = self.cadastre_mirror.dependent_mirrors.find(dependent_id)

      return false if !self.documents.where(document_type_id: 16, dependent_mirror_id: dependent.id).present?

      if dependent.special_condition_id == 2
        return false if !self.documents.where(document_type_id: 17, dependent_mirror_id: dependent.id).present?
      end

      if dependent.age >= 14
        return false if !self.documents.where(document_type_id: 18, dependent_mirror_id: dependent.id).present?
      end

      if dependent.age >= 18
        return false if !self.documents.where(document_type_id: 20, dependent_mirror_id: dependent.id).present?
      end

      if dependent.kinship_id == 5
        return false if !self.documents.where(document_type_id: 19, dependent_mirror_id: dependent.id).present?
      end

      if dependent.kinship_id == 1
        return false if !self.documents.where(document_type_id: 40, dependent_mirror_id: dependent.id).present?
      end

      return true
    end

    def allow_dependents
      dependents = self.cadastre_mirror.dependent_mirrors

      dependents.each do |dependent|
        return false if !allow_dependent(dependent.id)
      end

      return true
    end

    def allow_documents
      return false if !(self.documents.where(document_type_id: [21,22,23,24,25,26,27,28,29]).count >= 9)

      return true
    end

    def allow_income_dependent dependent_id
      dependent = self.cadastre_mirror.dependent_mirrors.find(dependent_id)

      if dependent.age >= 18
        return false if !self.documents.where(document_type_id: 15, dependent_mirror_id: dependent_id).present?
      end

      return true
    end


    def allow_income
      dependents = self.cadastre_mirror.dependent_mirrors

      return false if !self.documents.where(document_type_id: 14).present?

      dependents.each do |dependent|
        if dependent.age >= 18
          return false if !self.documents.where(document_type_id: [15], dependent_mirror_id: dependent.id).present?
        end
      end

      return true
    end

    def closed
      self.action_one && self.action_two && self.action_three && self.action_four && self.action_five
    end

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

      new_mirror.save(validate: false)


      current_dependents.each do |dependent|
        new_dependent = new_mirror.dependent_mirrors.new
        dependent.attributes.each do |key, _value|
          unless %w(id created_at updated_at).include?(key)
            new_dependent[key] = dependent[key] if new_dependent.attributes.has_key?(key)
          end
        end
        new_dependent.save(validate: false)
      end

      self.cadastre_mirror_id = new_mirror.id

      save
    end


  end
end
