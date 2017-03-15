module Attendance
  class NotificationService
      
    attr_accessor :cadastre, :notification

    AUTH_TOKEN = APP_ENV['onesignal']['auth_token']
    APP_ID     = APP_ENV['onesignal']['app_id']

    def initialize(ticket: nil, cadastre: nil)
      @ticket   = ticket
      @cadastre = cadastre
    end

    def create(category_id: 1, content: "", title: nil, link: false, push: false)

      notification = Attendance::AttendanceNotification.new({
        cadastre_id: @cadastre.id,
        title: title,
        notification_category_id: category_id,
        content: content,
        link: link
      })

      notification.save 

      if push
        send_push(heading: notification.title, 
                  message: notification.content,
                  user_ids: notification.cadastre.mobile_user_token) 
      end
      
    end

    def attendance_created
      text = "Seu atendimento foi criado com sucesso, protocolo #{@ticket.id}"
      self.create(title: "Atendimento protocolado", content: text, push: true)
        
    end

    private

    def send_push(message: nil, user_ids: nil, heading: nil)

      return false if user_ids.nil? || message.nil?

      if user_ids.is_a?(Array)
        array = user_ids
      else
        array = []
        array << user_ids
      end

      params = {
        headings:{ en: heading },
        contents:{ en: message },
        include_player_ids: array 
      }

      @client = OneSignal::Client.new(auth_token: AUTH_TOKEN, app_id: APP_ID)

      begin
        @client.notifications.create(params)

        return true
      rescue Exception => e 
        puts e
      end
    end
    
  end
end