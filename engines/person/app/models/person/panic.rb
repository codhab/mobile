module Person
  class Panic < ActiveRecord::Base
      self.table_name = 'extranet.dashboard_panics'

      AUTH_TOKEN = APP_ENV['onesignal']['auth_token']
  		APP_ID = APP_ENV['onesignal']['app_id']

      belongs_to :station, class_name: "Person::Station"
      belongs_to :staff, class_name: "Core::Person::Staff"

      def push

        heading = "Solicitação de Pânico"
        message = <<-HTML
            Solicitado Em: #{self.station.name}
            Solicitado Por: #{self.staff.name}
        HTML

        params = {
          headings:{ en: heading },
          contents:{ en: message },
          include_player_ids: ["3bdaef19-592a-4582-a137-9f6f03652c5f"]
        }

        @client = OneSignal::Client.new(auth_token: AUTH_TOKEN, app_id: APP_ID)

        begin
          @client.notifications.create(params)
          puts @index
          @index += 1
          # return true
        rescue Exception => e
          puts e
        end
        puts @index
      end
  end
end
