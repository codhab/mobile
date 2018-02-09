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
      if self.cadastre_mirror.special_condition_id == 1
        self.documents.where(document_type_id: 1).present? &&
        self.documents.where(document_type_id: 2).present? &&
        self.documents.where(document_type_id: 3).present? &&
        self.documents.where(document_type_id: 4).present?
        self.documents.where(document_type_id: 8).present?
      else
        self.documents.where(document_type_id: 1).present? &&
        self.documents.where(document_type_id: 2).present? &&
        self.documents.where(document_type_id: 3).present? &&
        self.documents.where(document_type_id: 4).present?
      end
    end

    def allow_dependent dependent_id
      dependent = self.cadastre_mirror.dependent_mirrors.find(dependent_id)
      if dependent.special_condition_id == 1
        self.documents.where(document_type_id: 6, dependent_mirror_id: dependent.id).present? &&
        self.documents.where(document_type_id: 8, dependent_mirror_id: dependent.id).present?
      else
        self.documents.where(document_type_id: 6, dependent_mirror_id: dependent.id).present?
      end
    end

    def allow_dependents
      self.documents.where('dependent_mirror_id is not null').count >= self.cadastre_mirror.dependent_mirrors.count
    end

    def allow_income
    end

    def allow_contact
    end

    def allow_document
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
