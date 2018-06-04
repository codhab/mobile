module Healty
  class Check < ActiveRecord::Base
    self.table_name = 'extranet.address_checks'

    attr_accessor :lat_lng, :password_confirmation
  end
end
