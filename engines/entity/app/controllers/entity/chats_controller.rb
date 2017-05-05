require_dependency 'entity/application_controller'

module Entity
  class ChatsController < ApplicationController

    def index
      @chats = current_entity.chats
     # @chats = Core::Attendance::ChatPolicy.new(@chats)
    end

    def new
      @chat = current_entity.attendance_chats.new
      #@chat.chat_comments.build
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
      @chat = Core::Attendance::ChatPolicy.new(@chat)
      @service = Core::Attendance::ChatCommentService.new(nil, nil, @chat.chat_comments)
      @service.reading_comment!
    end

    private

      def set_params
        params.require(:attendance_chat).permit(:chat_category_id)
      end

  end
end
