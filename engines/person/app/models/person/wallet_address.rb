module Person
  class WalletAddress < ActiveRecord::Base
    self.table_name = 'extranet.schedule_data_references'

    default_scope { where(code:'shis') }

    scope :by_city,     -> (city_id) { where(city_agenda_id: city_id)}
    scope :by_block,    -> (block)   { where(block: block)}
    scope :by_address,  -> (address) { where(address_agenda: address)}

    has_many :data_reference_uploads, class_name: DataReferenceUpload, foreign_key: :data_reference_id, primary_key: :id

    accepts_nested_attributes_for :data_reference_uploads, allow_destroy: true, reject_if: proc { |att| att['document'].blank?}
  
  end
end