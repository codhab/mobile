module Attendance
  class ChatCommentsController < ApplicationController

    before_action :set_chat

    def new
      @chat_comment = @chat.chat_comments.new
    end

    def create
      @chat_comment = @chat.chat_comments.new(set_params)
      if @chat_comment.save
        @service = Core::Attendance::ChatCommentService.new(@chat, @chat_comment, nil)
        @service.candidate_notification!
       redirect_to chats_path
      else
       render :new
     end
    end

    private

      def set_params
        params.require(:attendance_chat_comment).permit(:content, chat_uploads_attributes: [:document, :id])
      end

      def set_chat
        @chat = current_cadastre.attendance_chats.find(params[:chat_id])
      end

  end
end
