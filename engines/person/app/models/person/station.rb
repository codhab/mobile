module Person
  class Station < ActiveRecord::Base
    self.table_name = 'extranet.technical_assistance_stations'

    belongs_to :city, class_name: "Address::City"
    belongs_to :station_type, class_name: "TechnicalAssistance::StationType"
    belongs_to :service_station, class_name: "Attendance::ServiceStation"

    has_many :responsibles, :dependent => :destroy

    validates_presence_of :name, :address, :schedule, :city, :latitude, :longitude
    validates_uniqueness_of :address, :name, :latitude, :longitude

    scope :by_city,   -> (city) { where(city_id: city) }
    scope :by_name,   -> (name) { where(id: name) }
    scope :by_status, -> (status = true) { where(:status => status) }

  end
end
