class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params)
    @message.user_id = current_user.id
    unless @message.save
      render "errors"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_conversation
    @conversation = current_user.conversations.find(params[:conversation_id])
  end
end
