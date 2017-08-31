require_dependency 'social/application_controller'

module Social
  class ChatCommentsController < ApplicationController # :nodoc:
    before_action :set_chat, only: %i[new_comment create_comment]

    def new
      @chat_comment = Core::Social::ChatCommentForm.new
    end

    def create
      @chat_comment = Core::Social::ChatCommentForm.new(set_params_form)
      if @chat_comment.valid?
        @chat_service = Core::Social::ChatService.new
        @chat = @chat_service.chat_create!(@chat_comment.chat_category, current_social.id)
        @chat_comment.chat_id = @chat.id
        @chat_comment.save
        #@service = Core::Social::ChatCommentService.new(@chat, @chat_comment, nil)
        #@service.candidate_notification!
        redirect_to chats_path
      else
        render :new
      end
    end

    def new_comment
      @chat_comment = @chat.chat_comments.new
    end

    def create_comment
      @chat_comment = @chat.chat_comments.new(set_params)
      if @chat_comment.save
        #@service = Core::Social::ChatCommentService.new(@chat, @chat_comment, nil)
        #@service.candidate_notification!
        redirect_to chats_path
      else
        render :new_comment
      end
    end

    private

    def set_params
      params.require(:social_chat_comment).permit(:content, chat_uploads_attributes: [:document, :id])
    end

    def set_params_form
      params.require(:social_chat_comment_form).permit(:chat_category, :content, chat_uploads_attributes: [:document, :id])
    end

    def set_chat
      @chat = current_social.chats.find(params[:chat_id])
    end
  end
end
