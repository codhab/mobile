class AddressCity < ApplicationRecord
  self.table_name = 'extranet.address_cities'
  
  belongs_to :address_state, foreign_key: :state_id

  scope :federal_district, -> { joins(:address_state)
                                .where('address_states.acronym = ?', 'DF')
                                .order(:name) }
end