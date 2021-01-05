require_dependency 'candidate/application_record'

module Candidate
  class PreHabilitado < ApplicationRecord
    self.table_name = 'extranet.todos_pre_habilitados'
  end
end
