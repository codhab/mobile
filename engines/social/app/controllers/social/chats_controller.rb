require_dependency 'social/application_controller'

module Social
  class ChatsController < ApplicationController

    def index
      @chats = current_social.chats
      @chats = Core::Social::ChatPolicy.new(@chats)
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
      @chat = current_social.chats.find(params[:id])
      @chat = Core::Social::ChatPolicy.new(@chat)
      @service = Core::Social::ChatCommentService.new(nil, nil, @chat.chat_comments)
      @service.reading_comment!
    end

    private

    def set_params
      params.require(:attendance_chat).permit(:chat_category_id)
    end

  end
end
