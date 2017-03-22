
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
      @chat.save
      redirect_to chats_path
    end

    def show
      @chat = current_cadastre.attendance_chats.find(params[:id])
      @chat_comments = @chat.chat_comments
      if @chat.chat_comments.where(candidate_read: false, candidate: false).present?
        @chat_comments.update_all(candidate_read: true, candidate_read_datetime: DateTime.now)
      end
    end

    private

      def set_params
        params.require(:attendance_chat).permit(:chat_category_id, chat_comments_attributes: [:content, :id])
      end

  end
end
