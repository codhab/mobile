module Healty
  class CheckUnit < ActiveRecord::Base
    self.table_name = 'extranet.address_check_units'

    has_many :checks
  end
end
