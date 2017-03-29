
module Attendance
  class ChatsController < ApplicationController


    def index
      @chats = current_cadastre.attendance_chats
    end

    def new
      @chat = current_cadastre.attendance_chats.new
      @chat.chat_comments.build
    end

    def create
      @chat = current_cadastre.attendance_chats.new(set_params)
      if @chat.save
        redirect_to new_chat_chat_comment_path(@chat)
      else
        render :new
      end
    end

    def show
      @chat = current_cadastre.attendance_chats.find(params[:id])
      @chat_comments = @chat.chat_comments
      if @chat.chat_comments.where(candidate_read: false, candidate: false).present?
        comments = @chat_comments.where(candidate: false)
        comments.update_all(candidate_read: true, candidate_read_datetime: DateTime.now)
        notifications = Core::Attendance::Notification.where(target_model: 'Core::Attendance::ChatComment', target_id: comments.ids)
        notifications.update_all(read: true, read_at: DateTime.now)
      end
    end

    private

      def set_params
        params.require(:attendance_chat).permit(:chat_category_id)
      end

  end
end
