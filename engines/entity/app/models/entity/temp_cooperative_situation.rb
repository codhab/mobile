module Entity
  class TempCooperativeSituation < ActiveRecord::Base
    self.table_name = 'sihabx.entity_cooperative_mirror_situations'

    belongs_to :situation, class_name: '::Entity::TempCooperativeSituationType', foreign_key: :situation_id
  end
end