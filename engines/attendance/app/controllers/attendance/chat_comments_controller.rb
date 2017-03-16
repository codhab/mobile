module Attendance
  class ChatCommentsController < ApplicationController

    before_action :set_chat

    def new
      @chat_comment = @chat.chat_comments.new
    end

    def create
      @chat_comment = @chat.chat_comments.new
    end

    private

      
      def set_chat
        @chat = current_cadastre.attendance_chats.find(params[:chat_id])
      end

  end
end
