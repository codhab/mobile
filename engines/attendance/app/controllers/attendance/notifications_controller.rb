
module Attendance
  class NotificationsController < ApplicationController
      
    def index
      @notifications = current_cadastre.attendance_notifications
    end

    def show
      @notification = current_cadastre.attendance_notifications.find(params[:id])
      @notification.update(read: true)
    end
  end
end