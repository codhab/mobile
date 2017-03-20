
module Attendance
  class NotificationsController < ApplicationController
      
    def index

      @notifications = current_cadastre.notifications
    end

    def show
      @notification = current_cadastre.notifications.find(params[:id])
      @notification.update(read: true)
    end
  end
end