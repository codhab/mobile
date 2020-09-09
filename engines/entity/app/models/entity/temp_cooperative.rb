module Entity
  class TempCooperative < ActiveRecord::Base
    self.table_name = 'sihabx.entity_cooperative_mirrors'

    has_many :temp_cooperative_situations, class_name: '::Entity::TempCooperativeSituation', foreign_key: :cooperative_mirror_id
  end
end