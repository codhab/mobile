
module Attendance
  class ChatsController < ApplicationController

    def index
      @chats = current_cadastre.attendance_chats
    end

    def new
    end

    def create
    end

    def show
      @chat = current_cadastre.attendance_chats.find(params[:id])
      @chat_comments = @chat.chat_comments
      @chat_comments.update_all(candidate_read: true)
    end

  end
end
