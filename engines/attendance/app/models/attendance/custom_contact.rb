require_dependency 'attendance/custom_dependent_mirror'
require_dependency 'attendance/custom_cadastre'

module Attendance
  class CustomContact < ActiveRecord::Base # :nodoc:
    self.table_name = 'extranet.candidate_cadastre_mirrors'

    validates :celphone, :city_id, :cep, :address, presence: true
  end
end
