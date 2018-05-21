module Healty
  class CheckAllotment < ActiveRecord::Base
    self.table_name = 'extranet.address_check_allotments'

    has_many :units, class_name: 'Healty::CheckUnit'

    enum situation_id: ['pendente', 'realizada', 'cancelada']
  end
end
