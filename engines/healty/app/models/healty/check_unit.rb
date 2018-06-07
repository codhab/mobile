module Healty
  class CheckUnit < ActiveRecord::Base
    self.table_name = 'extranet.address_check_units'

    has_many :checks
    has_many :check_images
  end
end
