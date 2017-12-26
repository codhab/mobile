require_dependency 'candidate/application_record'

module Candidate
  class LegalRent < ApplicationRecord
    self.table_name = 'extranet.candidate_legal_rents'
  end
end
